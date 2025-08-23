# Conclusion

Deformable object tracking remains a complex yet highly impactful area within computer vision, particularly for applications in healthcare, sports, and human-computer interaction. This project explored the challenges of tracking non-rigid objects, focusing on sports equipment such as resistance bands and gymnastic balls. By reviewing several approaches, the SpatialTracker method was identified as the most suitable for the task due to its ability to capture complex deformations over time.

In the next step, we made several adaptations to the SpatialTracker. To handle longer videos without running into memory limitations, we implemented a sliding window approach. Furthermore, we added another monocular depth estimator called Video Depth Anything and a segmentation pipeline to automatically extract the region of interest. Additionally, we created a video library for testing purposes and used a time-of-flight camera to generate ground-truth depth data.

**TODO: add conclusion of results**

Overall, the project lays a solid foundation for further research and development of automated tools that can support therapists and patients in exercise monitoring.

## Future work

Adaptive re-sampling (e.g., after long occlusions) and learned cross-chunk consistency could further reduce boundary artefacts and drift. Runtime still scales with grid density; uncertainty-aware sparsification would improve throughput on dense masks.

As potential future work, a more detailed exploration of other tracking models could be considered. In particular, the TAPIR model was not evaluated in this project and could be an interesting topic for further research. **TODO: The CoTracker, however, is unlikely to be pursued, as it forms the foundation for the SpatialTracker and generally results in lower performance**

Another avenue for future work could involve relaxing the ARAP constraints within the SpatialTracker. However, this would require significant modifications to the algorithm. Currently, the ARAP restriction groups individual pixels together, which may be disadvantageous in cases where pixels need to move independently. This could be an advantage in case of strong deformations such as resistance bands.

**TODO: another depth estimation model?**
