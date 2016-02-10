
cimport pcl_defs as cpp
from boost_shared_ptr cimport sp_assign

cdef class PointCloud_PointXYZRGBA:
    """Represents a cloud of points in 3-d space.

    A point cloud can be initialized from either a NumPy ndarray of shape
    (n_points, 3), from a list of triples, or from an integer n to create an
    "empty" cloud of n points.

    To load a point cloud from disk, use pcl.load.
    """
    def __cinit__(self, init=None):
        cdef PointCloud2 other

        self._view_count = 0

        sp_assign(<cpp.shared_ptr[cpp.PointCloud[cpp.PointXYZRGBA]]> self.thisptr2_shared, new cpp.PointCloud[cpp.PointXYZRGBA]())

        if init is None:
            return
        elif isinstance(init, (numbers.Integral, np.integer)):
            self.resize(init)
        elif isinstance(init, np.ndarray):
            self.from_array(init)
        elif isinstance(init, Sequence):
            self.from_list(init)
        elif isinstance(init, type(self)):
            other = init
            self.thisptr2()[0] = other.thisptr2()[0]
        else:
            raise TypeError("Can't initialize a PointCloud from a %s"
                            % type(init))

    property width:
        """ property containing the width of the point cloud """
        def __get__(self): return self.thisptr2().width
    property height:
        """ property containing the height of the point cloud """
        def __get__(self): return self.thisptr2().height
    property size:
        """ property containing the number of points in the point cloud """
        def __get__(self): return self.thisptr2().size()
    property is_dense:
        """ property containing whether the cloud is dense or not """
        def __get__(self): return self.thisptr2().is_dense

    def __repr__(self):
        return "<PointCloud of %d points>" % self.size

    # Buffer protocol support. Taking a view locks the pointcloud for
    # resizing, because that can move it around in memory.
    def __getbuffer__(self, Py_buffer *buffer, int flags):
        # TODO parse flags
        cdef Py_ssize_t npoints = self.thisptr2().size()

        if self._view_count == 0:
            self._view_count += 1
            self._shape[0] = npoints
            self._shape[1] = 3

        buffer.buf = <char *>&(cpp.getptr2_at(self.thisptr2(), 0).x)
        buffer.format = 'f'
        buffer.internal = NULL
        buffer.itemsize = sizeof(float)
        buffer.len = npoints * 3 * sizeof(float)
        buffer.ndim = 2
        buffer.obj = self
        buffer.readonly = 0
        buffer.shape = self._shape
        buffer.strides = _strides
        buffer.suboffsets = NULL

    def __releasebuffer__(self, Py_buffer *buffer):
        self._view_count -= 1

    # Pickle support. XXX this copies the entire pointcloud; it would be nice
    # to have an asarray member that returns a view, or even better, implement
    # the buffer protocol (https://docs.python.org/c-api/buffer.html).
    def __reduce__(self):
        return type(self), (self.to_array(),)

    property sensor_origin:
        def __get__(self):
            cdef cpp.Vector4f origin = self.thisptr2().sensor_origin_
            cdef float *data = origin.data()
            return np.array([data[0], data[1], data[2], data[3]],
                            dtype=np.float32)

    property sensor_orientation:
        def __get__(self):
            # NumPy doesn't have a quaternion type, so we return a 4-vector.
            cdef cpp.Quaternionf o = self.thisptr2().sensor_orientation_
            return np.array([o.w(), o.x(), o.y(), o.z()])

    @cython.boundscheck(False)
    def from_array(self, cnp.ndarray[cnp.float32_t, ndim=2] arr not None):
        """
        Fill this object from a 2D numpy array (float32)
        """
        assert arr.shape[1] == 3

        cdef cnp.npy_intp npts = arr.shape[0]
        self.resize(npts)
        self.thisptr2().width = npts
        self.thisptr2().height = 1

        cdef cpp.PointXYZRGBA *p
        for i in range(npts):
            p = cpp.getptr2(self.thisptr2(), i)
            p.x, p.y, p.z = arr[i, 0], arr[i, 1], arr[i, 2]

    @cython.boundscheck(False)
    def to_array(self):
        """
        Return this object as a 2D numpy array (float32)
        """
        cdef float x,y,z
        cdef cnp.npy_intp n = self.thisptr2().size()
        cdef cnp.ndarray[cnp.float32_t, ndim=2, mode="c"] result
        cdef cpp.PointXYZRGBA *p

        result = np.empty((n, 3), dtype=np.float32)

        for i in range(n):
            p = cpp.getptr2(self.thisptr2(), i)
            result[i, 0] = p.x
            result[i, 1] = p.y
            result[i, 2] = p.z
        return result

    def from_list(self, _list):
        """
        Fill this pointcloud from a list of 3-tuples
        """
        cdef Py_ssize_t npts = len(_list)
        cdef cpp.PointXYZRGBA *p

        self.resize(npts)
        self.thisptr2().width = npts
        self.thisptr2().height = 1
        for i, l in enumerate(_list):
            p = cpp.getptr2(self.thisptr2(), i)
            p.x, p.y, p.z = l

    def to_list(self):
        """
        Return this object as a list of 3-tuples
        """
        return self.to_array().tolist()

    def resize(self, cnp.npy_intp x):
        if self._view_count > 0:
            raise ValueError("can't resize PointCloud while there are"
                             " arrays/memoryviews referencing it")
        self.thisptr2().resize(x)

    def get_point(self, cnp.npy_intp row, cnp.npy_intp col):
        """
        Return a point (3-tuple) at the given row/column
        """
        cdef cpp.PointXYZRGBA *p = cpp.getptr2_at(<cpp.PointCloud[cpp.PointXYZRGBA]> self.thisptr2(), row, col)
        return p.x, p.y, p.z

    def __getitem__(self, cnp.npy_intp idx):
        cdef cpp.PointXYZRGBA *p = cpp.getptr2_at(<cpp.PointCloud[cpp.PointXYZRGBA]> self.thisptr2(), idx)
        return p.x, p.y, p.z

    def from_file(self, char *f):
        """
        Fill this pointcloud from a file (a local path).
        Only pcd files supported currently.

        Deprecated; use pcl.load instead.
        """
        return self._from_pcd_file(f)

    def _from_pcd_file(self, const char *s):
        cdef int error = 0
        with nogil:
            error = cpp.loadPCDFile(string(s), <cpp.PointCloud[cpp.PointXYZRGBA]> deref(self.thisptr2()))
        return error

    def _from_ply_file(self, const char *s):
        cdef int ok = 0
        with nogil:
            ok = cpp.loadPLYFile(string(s), <cpp.PointCloud[cpp.PointXYZRGBA]> deref(self.thisptr2()))
        return ok

    def to_file(self, const char *fname, bool ascii=True):
        """Save pointcloud to a file in PCD format.

        Deprecated: use pcl.save instead.
        """
        return self._to_pcd_file(fname, not ascii)

    def _to_pcd_file(self, const char *f, bool binary=False):
        cdef int error = 0
        cdef string s = string(f)
        with nogil:
            error = cpp.savePCDFile(s, <cpp.PointCloud[cpp.PointXYZRGBA]> deref(self.thisptr2()), binary)
        return error

    def _to_ply_file(self, const char *f, bool binary=False):
        cdef int error = 0
        cdef string s = string(f)
        with nogil:
            error = cpp.savePLYFile(s, <cpp.PointCloud[cpp.PointXYZRGBA]> deref(self.thisptr2()), binary)
        return error

