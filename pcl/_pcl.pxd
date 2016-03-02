# Header for _pcl.pyx functionality that needs sharing with other
# modules.

cimport pcl_defs as cpp

# class override
cdef class PointCloud:
    cdef cpp.PointCloudPtr_t thisptr_shared     # XYZ
    
    # Buffer protocol support.
    cdef Py_ssize_t _shape[2]
    cdef Py_ssize_t _view_count
    
    cdef inline cpp.PointCloud[cpp.PointXYZ] *thisptr(self) nogil:
        # Shortcut to get raw pointer to underlying PointCloud<PointXYZ>.
        return self.thisptr_shared.get()

# class override
cdef class PointCloud_PointXYZRGBA:
    # cdef cpp.PointCloudPtr_t thisptr_shared     # XYZ
    cdef cpp.PointCloudPtr2_t thisptr2_shared   # XYZRGBA
    
    # Buffer protocol support.
    cdef Py_ssize_t _shape[2]
    cdef Py_ssize_t _view_count
    
#    cdef inline cpp.PointCloud[cpp.PointXYZ] *thisptr(self) nogil:
#        # Shortcut to get raw pointer to underlying PointCloud<PointXYZ>.
#        return self.thisptr_shared.get()

    cdef inline cpp.PointCloud[cpp.PointXYZRGBA] *thisptr2(self) nogil:
        # Shortcut to get raw pointer to underlying PointCloud<PointXYZRGBA>.
        return self.thisptr2_shared.get()

# class override
cdef class Vertices:
    cdef cpp.VerticesPtr_t thisptr_shared     # Vertices
    
    # Buffer protocol support.
    cdef Py_ssize_t _shape[2]
    cdef Py_ssize_t _view_count
    
    cdef inline cpp.Vertices *thisptr(self) nogil:
        # Shortcut to get raw pointer to underlying Vertices
        return self.thisptr_shared.get()

