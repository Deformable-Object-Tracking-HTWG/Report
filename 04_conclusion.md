# 4 Conclusion

Deformable Object Tracking remains a complex yet highly impactful area within computer vision, particularly for applications in healthcare, sports, and human-computer interaction. 
This project explored the challenges of tracking non-rigid objects, focusing on sports equipment such as resistance bands and gymnastics balls. 
By reviewing several approaches, the SpatialTracker method was identified as the most suitable for the task due to its ability to capture complex deformations over time.

The SpatialTracker was adapted to the required specifications:
To handle longer videos without running into memory limitations, a sliding window approach was implemented. 
Furthermore another Monocular Depth Estimator called Video Depth Anything was added and a segmentation pipeline to automatically extract the region of interest was created. 
Additionally a video library for testing purposes was created and a Time of Flight camera was used to generate ground-truth depth data.

Overall, the evaluation shows that SpatialTracker can reliably track deformable objects under a range of conditions but its performance varies strongly by object type. 
While simple objects such as gymastics balls and sponges were tracked consistently, resistance bands posed a significant challenge due to their highly deformable shape, often reducing accuracy despite added markings. 
Runtime experiments revealed that GPU resources are the main bottleneck, with higher resolutions and longer clips increasing processing time and memory requirements, and RGB-D processing adding a predictable overhead of 10–20%. 
2D efficiency tests with ArUco markers confirmed good accuracy under movement and stretching but tracking degraded heavily under occlusion. 
Comparison with ToF ground truth further emphasized that accuracy depends more on object characteristics than on video length, and that reliable initialization masks are crucial for stable results.

Overall, the project lays a solid foundation for further research and development of automated tools that can support therapists and patients in exercise monitoring.

# 5 Future work

As potential future work, a more detailed exploration of other tracking models could be considered. 
In particular, the TAPIR model was not evaluated in this project and could be an interesting topic for further research.

Another avenue for future work could involve relaxing the ARAP constraints within the SpatialTracker. 
However, this would require significant modifications to the algorithm. 
Currently, the ARAP restriction groups individual pixels together, which may be disadvantageous in cases where pixels need to move independently. 
This could be an advantage in case of strong deformations such as resistance bands.

Adaptive re-sampling (e.g., after long occlusions) and learned cross-chunk consistency could further reduce boundary artefacts and drift. 
Runtime still scales with grid density, uncertainty-aware sparsification would improve throughput on dense masks.
