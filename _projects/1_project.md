---
layout: page
title: Multi-channel Volume Rendering
description: For Large Wall Displays
img: MultiChannel_Volume_Rendering_1.jpg
importance: 1
category: work
related_publications: false
---

Large wall displays (LWDs) can achieve resolutions that are traditionally unattainable with standard desktop setups. Stereoscopic facilities offering gigapixel resolutions have also been developed, pushing these limits even further {% cite 10937398 %}. Moreover, the large spatial dimensions and extensive screen real estate of such facilities have been shown to enhance human perception and cognition {% cite 10.1145/1753326.1753336 %}.

Therefore, it is essential to explore the potential of these facilities in advancing scientific and medical analyses. This project aims to address that objective. By implementing volumetric rendering techniques tailored specifically for LWDs—considering their display configurations, multi-node distributed architectures, and unique interactivity requirements—this work seeks to evaluate their usability for scientific volumetric analysis.

<div class="row justify-content-sm-center">
    <div class="col-sm-6 mt-3 mt-md-0">
        {% include figure.liquid path="assets/img/MultiChannel_Volume_Rendering_1.jpg" title="EM Volume Rendering 1" class="img-fluid rounded z-depth-1" %}
    </div>
    <div class="col-sm-6 mt-3 mt-md-0">
        {% include figure.liquid path="assets/img/MultiChannel_Volume_Rendering_2.jpg" title="EM Volume Rendering 2" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    Volume renderings of proteins captured using electron microscopy, displayed on the LWD facility FlexiCAVE.
</div>

To enable interactive exploration of the volume, we have designed a novel web based frontend, which allows all of exploration, slicing and transfer function editing.

{% raw %}

```html
<div class="row justify-content-sm-center">
  <div class="col-sm-8 mt-3 mt-md-0">
    {% include figure.liquid path="assets/img/MultiChannel_Volume_Rendering_3.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
  </div>
  <div class="col-sm-4 mt-3 mt-md-0">
    {% include figure.liquid path="assets/img/MultiChannel_Volume_Rendering_4.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
  </div>
</div>
<div class="caption">
    Using the frontend on a handheld device within the LWD facility Silo.
</div>
```

{% endraw %}
