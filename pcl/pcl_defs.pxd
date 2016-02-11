from libc.stddef cimport size_t

from libcpp.vector cimport vector
from libcpp.string cimport string
from libcpp cimport bool

# NG
# from libcpp.memory cimport shared_ptr
from boost_shared_ptr cimport shared_ptr

from vector cimport vector as vector2

###############################################################################
# Types
###############################################################################

cdef extern from "Eigen/Eigen" namespace "Eigen" nogil:
    cdef cppclass Vector4f:
        float *data()
    cdef cppclass Quaternionf:
        float w()
        float x()
        float y()
        float z()
    cdef cppclass aligned_allocator[T]:
        pass

cdef extern from "pcl/point_cloud.h" namespace "pcl":
    cdef cppclass PointCloud[T]:
        PointCloud() except +
        PointCloud(unsigned int, unsigned int) except +
        unsigned int width
        unsigned int height
        bool is_dense
        void resize(size_t) except +
        size_t size()
        #T& operator[](size_t)
        #T& at(size_t) except +
        #T& at(int, int) except +
        shared_ptr[PointCloud[T]] makeShared()

        Quaternionf sensor_orientation_
        Vector4f sensor_origin_

# use cython type ?
# ctypedef fused PointCloudTypes:
#     PointXYZ
#     PointXYZRGBA

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct PointXYZ:
        PointXYZ()
        float x
        float y
        float z
    cdef struct Normal:
        pass

# cdef extern from "pcl/point_types.h" namespace "pcl":
#      cdef struct Normal:
#       float normal_x
#       float normal_y
#       float normal_z
#       float curvature

cdef extern from "pcl/point_types.h" namespace "pcl":
     cdef struct PointXYZRGBA:
         PointXYZRGBA()
         float x
         float y
         float z
         # uint32_t rgba
         unsigned long rgba

cdef extern from "pcl/point_types.h" namespace "pcl":
     cdef struct PointXYZRGBL:
         PointXYZRGBA()
         float x
         float y
         float z
         # uint32_t rgba
         unsigned long rgba
         # uint32_t label
         unsigned long label

cdef extern from "pcl/point_types.h" namespace "pcl":
     cdef struct PointXYZHSV:
         PointXYZHSV()
         float x
         float y
         float z
         float h
         float s
         float v

cdef extern from "pcl/point_types.h" namespace "pcl":
     cdef struct PointXY:
         PointXY()
         float x
         float y

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct InterestPoint:
        InterestPoint()
        float x
        float y
        float z
        float strength

cdef extern from "pcl/point_types.h" namespace "pcl":
     cdef struct PointXYZI:
        PointXYZI()
        float x
        float y
        float z
        float intensity

cdef extern from "pcl/point_types.h" namespace "pcl":
     cdef struct PointXYZL:
        PointXYZL()
        float x
        float y
        float z
        unsigned long label

cdef extern from "pcl/point_types.h" namespace "pcl":
     cdef struct Label:
        Label()
        # uint32_t label
        unsigned long label

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct Axis:
        Axis()
        float normal_x
        float normal_y
        float normal_z

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct PointNormal:
        PointNormal()
        float x
        float y
        float z
        float normal_x
        float normal_y
        float normal_z
        float curvature

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct PointXYZRGBNormal:
        PointXYZRGBNormal()
        float x
        float y
        float z
        float rgb
        float normal_x
        float normal_y
        float normal_z
        float curvature

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct PointXYZINormal:
        PointXYZINormal()
        float x
        float y
        float z
        float intensity
        float normal_x
        float normal_y
        float normal_z
        float curvature

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct PointWithRange:
        PointWithRange()
        float x
        float y
        float z
        float range

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct PointWithViewpoint:
        PointWithViewpoint()
        float x
        float y
        float z
        float vp_x
        float vp_y
        float vp_z

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct MomentInvariants:
        MomentInvariants()
        float j1
        float j2
        float j3

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct PrincipalRadiiRSD:
        PrincipalRadiiRSD()
        float r_min
        float r_max

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct Boundary:
        Boundary()
        # uint8_t boundary_point
        unsigned char boundary_point

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct PrincipalCurvatures:
        PrincipalCurvatures()
        float principal_curvature_x
        float principal_curvature_y
        float principal_curvature_z
        float pc1
        float pc2

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct PFHSignature125:
        PFHSignature125()
        float[125] histogram

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct PFHRGBSignature250:
        PFHRGBSignature250()
        float[250] histogram

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct PPFSignature:
        PPFSignature()
        float f1
        float f2
        float f3
        float f4
        float alpha_m

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct PPFRGBSignature:
        PPFRGBSignature()
        float f1
        float f2
        float f3
        float f4
        float r_ratio
        float g_ratio
        float b_ratio
        float alpha_m

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct NormalBasedSignature12:
        NormalBasedSignature12()
        float[12] values

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct SHOT352:
        SHOT352()
        float[352] descriptor
        float[9] rf

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct SHOT1344:
        SHOT1344()
        float[1344] descriptor
        float[9] rf

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct FPFHSignature33:
        FPFHSignature33()
        float[33] histogram

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct VFHSignature308:
        VFHSignature308()
        float[308] histogram

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct ESFSignature640:
        ESFSignature640()
        float[640] histogram

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct Narf36:
        Narf36()
        float[36] descriptor

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct GFPFHSignature16:
        GFPFHSignature16()
        float[16] histogram

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct IntensityGradient:
        IntensityGradient()
        float gradient_x
        float gradient_y
        float gradient_z

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct PointWithScale:
        PointWithScale()
        float x
        float y
        float z
        float scale

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct PointSurfel:
        PointSurfel()
        float x
        float y
        float z
        float normal_x
        float normal_y
        float normal_z
        # uint32_t rgba
        unsigned long rgba
        float radius
        float confidence
        float curvature

cdef extern from "pcl/point_types.h" namespace "pcl":
    cdef struct ReferenceFrame:
        ReferenceFrame()
        float[3] x_axis
        float[3] y_axis
        float[3] z_axis
        # float confidence

cdef extern from "pcl/features/normal_3d.h" namespace "pcl":
    cdef cppclass NormalEstimation[T, N]:
        NormalEstimation()

cdef extern from "pcl/segmentation/sac_segmentation.h" namespace "pcl":
    cdef cppclass SACSegmentationFromNormals[T, N]:
        SACSegmentationFromNormals()
        void setOptimizeCoefficients (bool)
        void setModelType (SacModel)
        void setMethodType (int)
        void setNormalDistanceWeight (float)
        void setMaxIterations (int)
        void setDistanceThreshold (float)
        void setRadiusLimits (float, float)
        void setInputCloud (shared_ptr[PointCloud[T]])
        void setInputNormals (shared_ptr[PointCloud[N]])
        void setEpsAngle (double ea)
        void segment (PointIndices, ModelCoefficients)
        void setMinMaxOpeningAngle(double, double)
        void getMinMaxOpeningAngle(double, double)


    cdef cppclass SACSegmentation[T]:
        void setOptimizeCoefficients (bool)
        void setModelType (SacModel)
        void setMethodType (int)
        void setDistanceThreshold (float)
        void setInputCloud (shared_ptr[PointCloud[T]])
        void segment (PointIndices, ModelCoefficients)

ctypedef SACSegmentation[PointXYZ] SACSegmentation_t
ctypedef SACSegmentation[PointXYZRGBA] SACSegmentation2_t
ctypedef SACSegmentationFromNormals[PointXYZ,Normal] SACSegmentationNormal_t
ctypedef SACSegmentationFromNormals[PointXYZRGBA,Normal] SACSegmentationNormal2_t

cdef extern from "pcl/surface/mls.h" namespace "pcl":
    cdef cppclass MovingLeastSquares[I,O]:
        MovingLeastSquares()
        void setInputCloud (shared_ptr[PointCloud[I]])
        void setSearchRadius (double)
        void setPolynomialOrder(bool)
        void setPolynomialFit(int)
        void process(PointCloud[O] &) except +

ctypedef MovingLeastSquares[PointXYZ,PointXYZ] MovingLeastSquares_t
ctypedef MovingLeastSquares[PointXYZRGBA,PointXYZRGBA] MovingLeastSquares2_t

cdef extern from "pcl/search/kdtree.h" namespace "pcl::search":
    cdef cppclass KdTree[T]:
        KdTree()
        void setInputCloud (shared_ptr[PointCloud[T]])

ctypedef KdTree[PointXYZ] KdTree_t
ctypedef KdTree[PointXYZRGBA] KdTree2_t

ctypedef aligned_allocator[PointXYZ] aligned_allocator_t 
ctypedef vector2[PointXYZ, aligned_allocator_t] AlignedPointTVector_t

cdef extern from "pcl/octree/octree_pointcloud.h" namespace "pcl::octree":
    cdef cppclass OctreePointCloud[T]:
        OctreePointCloud(double)
        void setInputCloud (shared_ptr[PointCloud[T]])
        void defineBoundingBox()
        void defineBoundingBox(double, double, double, double, double, double)
        void addPointsFromInputCloud()
        void deleteTree()
        bool isVoxelOccupiedAtPoint(double, double, double)
        int getOccupiedVoxelCenters(AlignedPointTVector_t)  
        void deleteVoxelAtPoint(PointXYZ)

ctypedef OctreePointCloud[PointXYZ] OctreePointCloud_t

cdef extern from "pcl/octree/octree_search.h" namespace "pcl::octree":
    cdef cppclass OctreePointCloudSearch[T]:
        OctreePointCloudSearch(double)
        int radiusSearch (PointXYZ, double, vector[int], vector[float], unsigned int)

ctypedef OctreePointCloudSearch[PointXYZ] OctreePointCloudSearch_t

cdef extern from "pcl/ModelCoefficients.h" namespace "pcl":
    cdef struct ModelCoefficients:
        vector[float] values

cdef extern from "pcl/PointIndices.h" namespace "pcl":
    #FIXME: I made this a cppclass so that it can be allocated using new (cython barfs otherwise), and
    #hence passed to shared_ptr. This is needed because if one passes memory allocated
    #using malloc (which is required if this is a struct) to shared_ptr it aborts with
    #std::bad_alloc
    #
    #I don't know if this is actually a problem. It is cpp and there is no incompatibility in
    #promoting struct to class in this instance
    cdef cppclass PointIndices:
        vector[int] indices

ctypedef PointIndices PointIndices_t
ctypedef shared_ptr[PointIndices] PointIndicesPtr_t

cdef extern from "pcl/io/pcd_io.h" namespace "pcl::io":
    # XYZ
    int load(string file_name, PointCloud[PointXYZ] &cloud) nogil except +
    int loadPCDFile(string file_name,
                    PointCloud[PointXYZ] &cloud) nogil except +
    int savePCDFile(string file_name, PointCloud[PointXYZ] &cloud,
                    bool binary_mode) nogil except +
    # XYZRGBA
    int load(string file_name, PointCloud[PointXYZRGBA] &cloud) nogil except +
    int loadPCDFile(string file_name,
                    PointCloud[PointXYZRGBA] &cloud) nogil except +
    int savePCDFile(string file_name, PointCloud[PointXYZRGBA] &cloud,
                    bool binary_mode) nogil except +

cdef extern from "pcl/io/ply_io.h" namespace "pcl::io":
    # XYZ
    int loadPLYFile(string file_name,
                    PointCloud[PointXYZ] &cloud) nogil except +
    int savePLYFile(string file_name, PointCloud[PointXYZ] &cloud,
                    bool binary_mode) nogil except +
    # XYZRGBA
    int loadPLYFile(string file_name,
                    PointCloud[PointXYZRGBA] &cloud) nogil except +
    int savePLYFile(string file_name, PointCloud[PointXYZRGBA] &cloud,
                    bool binary_mode) nogil except +

#http://dev.pointclouds.org/issues/624
#cdef extern from "pcl/io/ply_io.h" namespace "pcl::io":
#    int loadPLYFile (string file_name, PointCloud[PointXYZ] cloud)
#    int savePLYFile (string file_name, PointCloud[PointXYZ] cloud, bool binary_mode)

ctypedef PointCloud[PointXYZ] PointCloud_t
ctypedef PointCloud[PointXYZRGBA] PointCloud2_t
ctypedef PointCloud[Normal] PointNormalCloud_t
ctypedef shared_ptr[PointCloud[PointXYZ]] PointCloudPtr_t
ctypedef shared_ptr[PointCloud[PointXYZRGBA]] PointCloudPtr2_t

cdef extern from "pcl/filters/statistical_outlier_removal.h" namespace "pcl":
    cdef cppclass StatisticalOutlierRemoval[T]:
        StatisticalOutlierRemoval()
        int getMeanK()
        void setMeanK (int nr_k)
        double getStddevMulThresh()
        void setStddevMulThresh (double std_mul)
        bool getNegative()
        void setNegative (bool negative)
        void setInputCloud (shared_ptr[PointCloud[T]])
        void filter(PointCloud[T] &c)

ctypedef StatisticalOutlierRemoval[PointXYZ] StatisticalOutlierRemoval_t

cdef extern from "pcl/filters/voxel_grid.h" namespace "pcl":
    cdef cppclass VoxelGrid[T]:
        VoxelGrid()
        void setLeafSize (float, float, float)
        void setInputCloud (shared_ptr[PointCloud[T]])
        void filter(PointCloud[T] c)

ctypedef VoxelGrid[PointXYZ] VoxelGrid_t

cdef extern from "pcl/filters/passthrough.h" namespace "pcl":
    cdef cppclass PassThrough[T]:
        PassThrough()
        void setFilterFieldName (string field_name)
        void setFilterLimits (float, float)
        void setInputCloud (shared_ptr[PointCloud[T]])
        void filter(PointCloud[T] c)

ctypedef PassThrough[PointXYZ] PassThrough_t

cdef extern from "pcl/kdtree/kdtree_flann.h" namespace "pcl":
    cdef cppclass KdTreeFLANN[T]:
        KdTreeFLANN()
        void setInputCloud (shared_ptr[PointCloud[T]])
        int nearestKSearch (PointCloud[T], int, int, vector[int], vector[float])

ctypedef KdTreeFLANN[PointXYZ] KdTreeFLANN_t
# ctypedef KdTreeFLANN[PointXYZRGB] KdTreeFLANN_t2

###############################################################################
# Enum
###############################################################################
cdef extern from "pcl/sample_consensus/model_types.h" namespace "pcl":
    cdef enum SacModel:
        SACMODEL_PLANE
        SACMODEL_LINE
        SACMODEL_CIRCLE2D
        SACMODEL_CIRCLE3D
        SACMODEL_SPHERE
        SACMODEL_CYLINDER
        SACMODEL_CONE
        SACMODEL_TORUS
        SACMODEL_PARALLEL_LINE
        SACMODEL_PERPENDICULAR_PLANE
        SACMODEL_PARALLEL_LINES
        SACMODEL_NORMAL_PLANE
        SACMODEL_NORMAL_SPHERE
        SACMODEL_REGISTRATION
        SACMODEL_PARALLEL_PLANE
        SACMODEL_NORMAL_PARALLEL_PLANE
        SACMODEL_STICK

cdef extern from "pcl/sample_consensus/method_types.h" namespace "pcl":
    cdef enum:
        SAC_RANSAC = 0
        SAC_LMEDS = 1
        SAC_MSAC = 2
        SAC_RRANSAC = 3
        SAC_RMSAC = 4
        SAC_MLESAC = 5
        SAC_PROSAC = 6

###############################################################################
# Activation
###############################################################################
