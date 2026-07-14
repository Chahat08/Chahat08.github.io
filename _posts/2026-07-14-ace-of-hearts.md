---
title: Ace of Hearts (Shadertoy)
teaser: blog/ace_of_hearts/ace_of_hearts.png
teaser_alt: Ace of Hearts shader
featured: false
graphic: true
graphic_video: blog/ace_of_hearts/ace_of_hearts.webm
graphic_poster: blog/ace_of_hearts/ace_of_hearts.png
graphic_caption: Ace of Hearts (Shadertoy)
---

<video class="graphic-embed" controls autoplay loop muted playsinline
       poster="{{ '/assets/blog/ace_of_hearts/ace_of_hearts.png' | relative_url }}">
  <source src="{{ '/assets/blog/ace_of_hearts/ace_of_hearts.webm' | relative_url }}" type="video/webm">
  Your browser does not support the video tag.
</video>

I made this as an initial exploration into 2D SDFs — practicing how to define and combine 2D signed distance fields. You can see it live [here on Shadertoy](https://www.shadertoy.com/view/sf3GW7).

**Resources:**

- [Shadertoy Tutorial Part 5 — inspirnathan](https://inspirnathan.com/posts/51-shadertoy-tutorial-part-5/)
- [2D distance functions — Inigo Quilez](https://iquilezles.org/articles/distfunctions2d/)
- [Distance functions — Inigo Quilez](https://iquilezles.org/articles/distfunctions/)

```glsl
float dot2( in vec2 v ) { return dot(v,v); }

vec2 translate(vec2 uv, vec2 offset)
{
    return uv-offset;
}

vec2 scale(vec2 uv, vec2 scale)
{
    return uv/scale;
}

vec2 rotate(vec2 uv, float angle)
{
    return mat2(cos(angle),sin(angle),-sin(angle),cos(angle))*uv;
}

// https://mathworld.wolfram.com/HeartCurve.html#:~:text=A%20sixth%20heart%20curve%20is%20given%20by%20the%20simple%20expression
float sdHeart(vec2 uv)
{
    return (uv.x*uv.x)+pow((uv.y-pow((uv.x*uv.x),1./3.)),2.)-1.;
}

float opRepHeart(vec2 p,vec2 c)
{
    vec2 q = mod(p+0.5*c,c)-0.5*c;
    q = scale(q, vec2(0.02 + 0.01*sin(iTime)));
    return sdHeart(q);
}

// https://www.shadertoy.com/view/MlycD3
float sdTrapezoid( in vec2 p, in float r1, float r2, float he )
{
    vec2 k1 = vec2(r2,he);
    vec2 k2 = vec2(r2-r1,2.0*he);
    p.x = abs(p.x);
    vec2 ca = vec2(p.x-min(p.x,(p.y<0.0)?r1:r2), abs(p.y)-he);
    vec2 cb = p - k1 + k2*clamp( dot(k1-p,k2)/dot2(k2), 0.0, 1.0 );
    float s = (cb.x<0.0 && ca.y<0.0) ? -1.0 : 1.0;
    return s*sqrt( min(dot2(ca),dot2(cb)) );
}

// https://www.shadertoy.com/view/MldcD7
float sdTriangleIsosceles( in vec2 p, in vec2 q )
{
    p.x = abs(p.x);
    vec2 a = p - q*clamp( dot(p,q)/dot(q,q), 0.0, 1.0 );
    vec2 b = p - q*vec2( clamp( p.x/q.x, 0.0, 1.0 ), 1.0 );
    float s = -sign( q.y );
    vec2 d = min( vec2( dot(a,a), s*(p.x*q.y-p.y*q.x) ),
                  vec2( dot(b,b), s*(p.y-q.y)  ));
    return -sqrt(d.x)*sign(d.y);
}

// https://iquilezles.org/articles/distfunctions2d/
float sdBox( in vec2 p, in vec2 b )
{
    vec2 d = abs(p)-b;
    return length(max(d,0.0)) + min(max(d.x,d.y),0.0);
} 

// https://iquilezles.org/articles/distfunctions2d/
float opRound( in vec2 p, in vec2 b, in float r )
{
  return sdBox(p,b) - r;
}

float sdATop(vec2 uv)
{
   /*The shape of A is made by having a base triangle
   from which we subtract another triangle and a trapezium to extract the empty portions of the letter 'A'
   and then we add 3 boxes to the legs and the top of the letter
   */
   
    vec2 aScale=vec2(0.2);
    vec2 aTranslate=vec2(-1.,1.1);

    vec2 baseTriangleTop=vec2(0.1,-0.4); //haflWidth,height
    vec2 baseTriangleOffset=vec2(0.,-baseTriangleTop.y/2.);

    vec2 baseTrianglePos = 
        translate(
            translate(scale(uv,aScale),
            baseTriangleOffset),
            aTranslate
        );

    float dBaseTriangle =
        sdTriangleIsosceles(baseTrianglePos,baseTriangleTop);


    vec2 layeredTriangleTop=vec2(0.025,-0.15);
    vec2 layeredTriangleOffset=vec2(0.,-layeredTriangleTop.y/2.);

    vec2 layeredTrianglePos =
        translate(
            translate(scale(uv,aScale),
            layeredTriangleOffset),
            aTranslate
        );

    float dLayeredTriangle =
        sdTriangleIsosceles(layeredTrianglePos,layeredTriangleTop);


    vec3 layeredTrapezoidDim=vec3(0.06,0.04,.05); //baseW,topW,height

    vec2 layeredTrapezoidOffset=vec2(0.,-0.175);

    vec2 layeredTrapezoidPos =
        translate(
            translate(scale(uv,aScale),
            layeredTrapezoidOffset),
            aTranslate
        );

    float dLayeredTrapezoid =
        sdTrapezoid(
            layeredTrapezoidPos,
            layeredTrapezoidDim.x,
            layeredTrapezoidDim.y,
            layeredTrapezoidDim.z
        );


    vec2 boxLeftBottomH=vec2(0.04,0.015); //width,height
    vec2 boxLeftBottomOffset=vec2(-0.075,-0.2);

    float dBoxLeftBottom =
        sdBox(
            translate(
                translate(scale(uv,aScale),
                boxLeftBottomOffset),
                aTranslate),
            boxLeftBottomH
        );


    vec2 boxRightBottomOffset=vec2(0.075,-0.2);

    float dBoxRightBottom =
        sdBox(
            translate(
                translate(scale(uv,aScale),
                boxRightBottomOffset),
                aTranslate),
            boxLeftBottomH
        );


    vec2 boxTopOffset=vec2(0.0,0.18);

    float dBoxTop =
        sdBox(
            translate(
                translate(scale(uv,aScale),
                boxTopOffset),
                aTranslate),
            boxLeftBottomH
        );


    float result=max(dBaseTriangle,-dLayeredTriangle);
    result=max(result,-dLayeredTrapezoid);
    result=min(result,dBoxLeftBottom);
    result=min(result,dBoxRightBottom);
    result=min(result,dBoxTop);

    return result;
}

vec3 scene(vec2 uv)
{
    vec3 scene=vec3(0.);
    
    //background
    float bands = step(0.0, sin(100.*uv.x - 10.0*iTime));
    vec3 bgColor = vec3(bands);
    float bgHearts=smoothstep(-1.,1.,opRepHeart(uv,vec2(0.1,0.1)));

    // red color
    const vec3 RED=vec3(1.0,0.,0.);
    const float PI = 3.14159265359;
    
    // card rounded box
    float cardR=0.05;
    vec2 cardDim=vec2(0.25,0.3);
    float dCard=opRound(uv,cardDim,cardR);
    float cardIntensity =clamp(1.0 + dCard/max(cardDim.x,cardDim.y),0.0,1.0);
    vec3 cardColor = vec3(242., 240., 220.)/255.*vec3(cardIntensity);
    
    // heart middle
    vec2 heartMiddleScale=vec2(0.06);
    vec2 heartMiddlePos=scale(uv,heartMiddleScale);
    float dHeartMiddle=sdHeart(heartMiddlePos);
    
    //heart top
    vec2 heartTopScale=vec2(0.02);
    vec2 heartTopOffset=vec2(-0.2,0.135);
    vec2 heartTopPos=scale(translate(uv,heartTopOffset),heartTopScale);
    float dHeartTop=sdHeart(heartTopPos);
    
    //heart bottom
    vec2 heartBottomScale=vec2(0.02);
    vec2 heartBottomOffset=vec2(0.2,-0.135);
    vec2 heartBottomPos=rotate(scale(translate(uv,heartBottomOffset),heartBottomScale),PI);
    float dHeartBottom=sdHeart(heartBottomPos); 
    
    // A top    
    float aTop = sdATop(uv);
    
    //A bottom
    float aBottom = sdATop(rotate(uv,PI));
    
    //mixing
    scene=bgColor;
    scene=mix(RED,scene,bgHearts);
    scene=mix(cardColor,scene,step(0.,dCard));
    scene=mix(RED,scene,step(0.,dHeartMiddle));
    scene=mix(RED,scene,step(0.,dHeartTop));
    scene=mix(RED,scene,step(0.,dHeartBottom));
    scene=mix(RED,scene,step(0.,aTop));
    scene=mix(RED,scene,step(0.,aBottom));
    
    
    return scene;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    uv-=0.5; //-.5,.5
    uv.x*=iResolution.x/iResolution.y;

    // Draw scene
    vec3 col=scene(uv);    
    

    // Output to screen
    fragColor = vec4(col,1.0);
}
```
