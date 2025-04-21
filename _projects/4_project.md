---
layout: page
title: Conformal Retargetting for LWDs
description: Recovering Information for Missing Display Surfaces in LWD Facilities
img: assets/img/Conformal_Mapping_Background.img
importance: 1
category: research
related_publications: true
---

Immersive facilities, while having their many advantages, also face a key challenge: the absence of certain display surfaces - such as floors, ceilings or entrances - which leads to incomplete information coverage and impaired navigation. 
We faced this issue when we were working on our LWD facility Silo {% cite SiloIEEEVR %}, it is a cylindrical facility with 21 columns, however there is a gap between them for a door, and it also lacks displays on the floor and the ceiling.

Conformal mapping using techniques such as Ricci Flow is one way to go about recovering this missing information. These angle-preserving mappings can be used to map a near complete shape (such as a capsule) to a flat texture, which can be applied to a shape with missing areas, such as the cylindrical Silo.


<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/Conformal_Mapping_RF_Capsule.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/Conformal_Mapping_RF_Map.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    Angle-preserving conformal mapping of a capsule.
</div>

While conformal mapping can recover missing regions, the results that it produces might look visually distorted. To correct them, we can apply area-preserving optimal transport (OT) to these mappings.

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/Conformal_Mapping_OT_Capsule.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/Conformal_Mapping_OT_Map.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    Area-preserving OT mapping of a capsule.
</div>

We can use raytracing to finally generate the texture for a conformal map in a scene.

<div class="row">
    <div class="col-sm-4 mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/Conformal_Mapping_RayTracing.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
    <div class="col-sm-8 mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/Conformal_Mapping_CM_OT_Comparison.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    Left, using raytracing to generate a cubemap texture. Right, comparison of textures obtained from (a) Conformal Mapping, and (b) Optimal Transport.
</div>

Finally, these textures can be applied to immersive facilities, such as the Silo {% cite SiloIEEEVR %} to obtain information that was previously hidden.

<div class="row justify-content-sm-center">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid path="assets/img/Conformal_Mapping_Silo_Results_.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid path="assets/img/Conformal_Mapping_Polyp.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    Left, we have mapping results in the Silo for (a) VC and (b) protein-folding structure. Insets show the full texture and the missing information recovered by the mapping highlighted in green. Right, Our mapping reveals a polyp in virtual colonoscopy which was otherwise hidden in the \textit{floor} of the Silo. (a) VC scene mapped on the Silo using our conformal+OT method. The green region highlights recovered information. (b) VC scene without mapping.
</div>