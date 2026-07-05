---
title: Rubies&Emeralds (Shadertoy)
teaser: blog/rubies_emeralds/rubies_emeralds.png
teaser_alt: Rubies&Emeralds shader
featured: false
graphic: true
graphic_video: blog/rubies_emeralds/rubies_emeralds.webm
graphic_poster: blog/rubies_emeralds/rubies_emeralds.png
graphic_caption: Rubies&Emeralds (Shadertoy)
---

<video class="graphic-embed" controls autoplay loop muted playsinline
       poster="{{ '/assets/blog/rubies_emeralds/rubies_emeralds.png' | relative_url }}">
  <source src="{{ '/assets/blog/rubies_emeralds/rubies_emeralds.webm' | relative_url }}" type="video/webm">
  Your browser does not support the video tag.
</video>

This one is a small extension of my earlier [Rainbow Weave]({{ '/2026/07/04/rainbow-weave/' | relative_url }}) shader, so I won't do a full step-by-step here. You can play with the live version [here on Shadertoy](https://www.shadertoy.com/view/sXSXWc). It reuses the same grid-of-cells idea and adds three things on top.

## 1. Adding edges

Each cell gets a dark border. Within a cell, `localX` and `localY` run 0–1, so the distance to the nearest cell edge is `min(local, 1.0 - local)` along each axis, and the overall `distToEdge` is the smaller of the two — small near the borders, larger toward the center. A `smoothstep(0.0, edgeWidth, distToEdge)` turns that into a mask, and mixing the cell color with black by that mask paints a soft frame. The `edgeWidth` itself is driven by a `sin(iTime)` so the borders gently pulse in and out.

## 2. Multiple color palettes

Instead of a single rainbow, there are now two palettes — a **ruby** set and an **emerald** set. The same checkerboard parity that decides scroll direction also picks the palette: cells that flow horizontally are colored from the ruby palette, and cells that flow vertically use the emerald one. This is why the two directions read as two different materials interlocking.

## 3. Local rotations

To give each cell some life, its local coordinates are rotated about the cell center before being used. We recenter `local` to `[-0.5, 0.5]`, apply a 2×2 rotation matrix by an angle that grows with `iTime`, then shift back. Feeding these rotated coordinates into the color interpolation makes the gradient inside every cell spin continuously.

```glsl
// This is a simple modification to my previous shader "Rainbow Weave"
// which adds some edges to the grid
// Rainbow Weave: https://www.shadertoy.com/view/sXSXDV

vec2 rotate(vec2 uv, float th)
{
    return mat2(cos(th),sin(th),-sin(th),cos(th))*uv;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv=fragCoord/iResolution.xy;//0,1
    
    // ruby color pallete
    // from https://colorhunt.co/palette/4a102a85193cc5172efcf259
    const int num_colors_x=4;
    vec3 xColors[num_colors_x]=vec3[]( 
                vec3(76.,16.,42.)/255.,
                vec3(133.,25.,60.)/255.,
                vec3(197.,23.,46.)/255.,
                vec3(252.,242.,89.)/255.
                );
                
    // emerald color pallete
    // from https://colorhunt.co/palette/9cb0806187642b5748273338        
    const int num_colors_y=4;
    vec3 yColors[num_colors_y]=vec3[]( // ruby color pallette
                vec3(156.,176.,128.)/255.,
                vec3(97.,135.,100.)/255.,
                vec3(43.,87.,72.)/255.,
                vec3(39.,51.,56.)/255.
                );
                
    
    float speed=0.5;
    float coord=0.;
    
    // gridding
    float num_cells_x=10.;
    float num_cells_y=num_cells_x*iResolution.y/iResolution.x;
    
    float cellX=uv.x * num_cells_x; //cellX is cell idx from 0-5
    float cellY=uv.y * num_cells_y; //cellX is cell idx from 0-5

    int bandX=int(floor(cellX));//band is 0,1,2,3,4,5
    int bandY=int(floor(cellY));//band is 0,1,2,3,4,5
    
    float localX = fract(cellX); //0-1 range (varying locally within each band)
    float localY = fract(cellY); //0-1 range (varying locally within each band)
    
    // rotate cell content about cell center
    float angle = iTime*0.2; // constant rotation in radians
    vec2 local = vec2(localX, localY);
    vec2 centered = local - 0.5;
    vec2 rotated = rotate(centered, angle);
    vec2 rotatedLocal = rotated + 0.5;

    float rotX = rotatedLocal.x;
    float rotY = rotatedLocal.y;
    
    float scaledCoord=0.;
    if (bandX % 2 == bandY % 2){
        coord=fract(rotX+iTime*speed); // local horizontal interpolation
        // color interpolations within each cell 
        scaledCoord=coord*float(num_colors_x); // scaledX is bw 0 and 6
        
    }
    else{
        coord=fract(rotY+iTime*speed);   // local vertical interpolation
        // color interpolations within each cell 
        scaledCoord=coord*float(num_colors_y); // scaledX is bw 0 and 6
   }    
   
    float val=fract(scaledCoord); // 6 0-1 ranges
    int idx=int(scaledCoord); // 0,1,...5,6
    vec3 col=vec3(0.);
    
    if (bandX % 2 == bandY % 2)
        col=mix(xColors[idx],xColors[(idx+1)%num_colors_x],val);
    else col=mix(yColors[idx],yColors[(idx+1)%num_colors_y],val);
    
    // GRID CELL EDGE COLORING
    float edgeSpeed=2.0;
    vec3 edgeColor=vec3(0.0); //black
    float minWidth=0.5, maxWidth=0.8;
    // time vayring thickness of border in local cell coordinates
    float edgeWidth=(((sin(iTime*edgeSpeed)+1.)/2.)*(maxWidth-minWidth))+minWidth; 
    
    // localX and localY are each [0,1]
    float distToEdgeX = min(localX, 1.0 - localX); // dist to nearest vertical edge
    float distToEdgeY = min(localY, 1.0 - localY); // dist to nearest horizontal edge
    float distToEdge = min(distToEdgeX, distToEdgeY); // small near edge, larger near center
    
    // get a value from dist=0.0 (on edge) to edgeWidth based on distToEdge
    float edgeMask = smoothstep(0.0, edgeWidth, distToEdge);
    
    // edgeMask=0.0 gives full edgeColor, edgeMask=1.0 (full color from pallete)
    vec3 finalCol = mix(edgeColor, col, edgeMask);
   
    
    fragColor=vec4(finalCol,1.);
}
```
