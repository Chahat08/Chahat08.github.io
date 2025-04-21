---
layout: page
title: Radial Volumetric Slicing
description: Physical Interaction to Virtual Transformation
img: assets/img/Radial_Slicing_Head_45.jpg
importance: 1
category: research
related_publications: true
giscus_comments: false
---

In Human-Computer Interaction, a fundamental concept is designing interactivity such that the action intuitively "affords" its generated response. For example, a light switch is designed in a way that naturally encourages flicking it.

The latest immersive facility at Stony Brook University, the FlexiCAVE {% cite FlexiCAVETemp %}, features dynamic columns with hinges that afford physical rotation. Leveraging this capability, we developed the concept of **PIVoT: Physical Interaction to Virtual Transformation**.

A novel use case of the PIVoT paradigm is radial slicing of volumetric datasets. By physically rotating the columns of the FlexiCAVE, users can dynamically slice through volumes along planes corresponding to the facility's physical configuration. This approach allows detailed internal analysis of scientific volumetric datasets.

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/Radial_Slicing_Head_Flat.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/Radial_Slicing_Head_45.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/Radial_Slicing_Head_90.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    Radial Slicing through an MRI (Magnetic Resonance Image) of a Human Brain. On the left, we have the FlexiCAVE in its flat configuration. Middle, with the left column set rotated such that the angle between them is 45 degrees. Right, the angle is 90 degrees.
</div>

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/Radial_Slicing_Chest_Flat.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/Radial_Slicing_Chest_45.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/Radial_Slicing_Chest_90.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    Radial Slicing through a CT scan (Computed Tomography) of a Human Chest. On the left, we have the FlexiCAVE in its flat configuration. Middle, with the left column set rotated such that the angle between them is 45 degrees. Right, the angle is 90 degrees.
</div>

Slicing which involves orientations involving rotations of other columns are also possible, which allow for a more vigorous exploration. This is shown in the following image.

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/Radial_Slicing_Other_Orientations.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    Some possible orientations of the FlexiCAVE with the rendering showing slicing based on that orientation.
</div>
