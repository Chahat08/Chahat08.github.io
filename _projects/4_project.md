---
layout: page
title: Conformal Retargetting for LWDs
description: Recovering Information for Missing Display Surfaces in LWD Facilities
img: assets/img/Conformal_Mapping_Background.img
importance: 1
category: research
related_publications: true
---

Immersive facilities, despite their numerous advantages, face a significant challenge: the absence of certain display surfaces-such as floors, ceilings, or entrances-which leads to incomplete visual coverage and impaired navigation. We encountered this issue while working on our Large Wall Display (LWD) facility, Silo {% cite SiloIEEEVR %}. Silo is a cylindrical facility composed of 21 columns; however, it includes a gap for an entrance and lacks display surfaces on both the floor and ceiling.

Conformal mapping techniques, such as Ricci Flow, offer a solution for recovering this missing information. These angle-preserving mappings allow us to transform a nearly complete 3D shape (such as a capsule) onto a flat texture, which can then be applied to facilities with missing display areas, like the cylindrical Silo.

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

However, while conformal mappings can recover missing regions, they can also introduce visual distortions. To address this, we can apply area-preserving Optimal Transport (OT) techniques to correct these distortions.

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

Ray tracing can then be used to generate textures based on these corrected conformal mappings. 

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

Finally, applying these textures to immersive facilities, such as the Silo {% cite SiloIEEEVR %}, allows us to visualize previously hidden information.

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