%test multiple view gemotry --book
% hese tasks and algorithms include:
% ? Given two images, and no other information, compute matches between the images, and the 3D position of the points that generate these matches and the cameras that generate the images.
% ? Given three images, and no other information, similarly compute the matches be- tween images of points and lines, and the position in 3D of these points and lines and the cameras.
% ? Compute the epipolar geometry of a stereo rig, and trifocal geometry of a trinocular rig, without requiring a calibration object.
% ? Compute the internal calibration of a camera from a sequence of images of natural scenes (i.e. calibration ¡°on the fly¡±).

% Many of the problems of reconstruction have now reached a level where we may claim that they are solved. Such problems include:
% (i) Estimation of the multifocal tensors from image point correspondences, par- ticularly the fundamental matrix and trifocal tensors (the quadrifocal tensor having not received so much attention).
% (ii) Extraction of the camera matrices from these tensors, and subsequent projective reconstruction from two, three and four views.

% (i) Application of bundle adjustment to solve more general reconstruction prob- lems.
% (ii) Metric (Euclidean) reconstruction given minimal assumptions on the camera matrices.
% (iii) Automatic detection of correspondences in image sequences, and elimination of outliers and false matches using the multifocal tensor relationships.