     subroutine write_wek(nx,ny,nt,X,Y,T,missing_value,wc,wvort,wsst,wcur)

      use netcdf 

      implicit none      

      character(len=*), parameter :: file_out="output_wek.nc"

      real :: missing_value

      integer :: nx, ny, nt

      real :: X(nx), Y(ny), T(nt), wc(nx,ny,nt), wvort(nx,ny,nt),wsst(nx,ny,nt), wcur(nx,ny,nt)

      integer, parameter :: NDIMS3 = 3

      character(len=*), parameter :: t_NAME="time"
      character(len=*), parameter :: x_NAME="longitude"
      character(len=*), parameter :: y_NAME="latitude"

      integer :: t_dimid, y_dimid, x_dimid, t_varid, y_varid, x_varid

      character(len=*), parameter :: wc_NAME="Wc"
      character(len=*), parameter :: wvort_NAME="Wvort"
      character(len=*), parameter :: wsst_NAME="Wsst"
      character(len=*), parameter :: wcur_NAME="Wcur"

      integer :: wc_varid, wvort_varid, wsst_varid, wcur_varid, dimids3(NDIMS3)

      character(len=*), parameter :: UNITS = "units"

      character(len=*), parameter :: t_UNITS=&    
      & "hours since 1950-1-1 00:00:00"
      character(len=*), parameter :: y_UNITS="degrees_north"
      character(len=*), parameter :: x_UNITS="degrees_east"

      character(len=*), parameter :: wc_UNITS="m/day"
      character(len=*), parameter :: wvort_UNITS="m/day"
      character(len=*), parameter :: wsst_UNITS="m/day"
      character(len=*), parameter :: wcur_UNITS="m/day"

      character(len=*), parameter :: LNAME="long_name"

      character(len=*), parameter :: t_LNAME=&
      &"days since 1950-1-1 00:00:00"
      character(len=*), parameter :: y_LNAME="Latitude"
      character(len=*), parameter :: x_LNAME="Longitude"
   
      character(len=*), parameter :: wc_LNAME=&
      "WEk induced by local surface currents"
      character(len=*), parameter :: wvort_LNAME=&
      &"WEk induced by Ekman transport and local vorticity"
      character(len=*), parameter :: wsst_LNAME=&
      &"WEk induced by spatial variability of SST"
      character(len=*), parameter :: wcur_LNAME=&
      &"WEk_cur = Wvort+Wc"

      integer :: retval, ncid, rhvarid

      retval = nf90_create(file_out,ior(nf90_noclobber,nf90_64bit_offset),ncid)

      retval = nf90_def_dim(ncid, t_NAME, NT, t_dimid)
      retval = nf90_def_dim(ncid, y_NAME, NY, y_dimid)
      retval = nf90_def_dim(ncid, x_NAME, NX, x_dimid)

      retval = nf90_def_var(ncid, t_NAME, NF90_REAL, t_dimid, t_varid)
      retval = nf90_def_var(ncid, y_NAME, NF90_REAL, y_dimid, y_varid)
      retval = nf90_def_var(ncid, x_NAME, NF90_REAL, x_dimid, x_varid)

      retval = nf90_put_att(ncid, t_varid, UNITS, t_UNITS)
      retval = nf90_put_att(ncid, y_varid, UNITS, y_UNITS)
      retval = nf90_put_att(ncid, x_varid, UNITS, x_UNITS)

      retval = nf90_put_att(ncid, t_varid, LNAME, t_LNAME)
      retval = nf90_put_att(ncid, y_varid, LNAME, y_LNAME)
      retval = nf90_put_att(ncid, x_varid, LNAME, x_LNAME)

      retval = nf90_put_att(ncid, rhvarid,"title",&
                &"written by fecg: fecampos1302@gmail.com")

      dimids3(1) = x_dimid
      dimids3(2) = y_dimid
      dimids3(3) = t_dimid

      retval = nf90_def_var(ncid, wc_NAME, NF90_REAL, dimids3, wc_varid)
      retval = nf90_def_var(ncid, wvort_NAME, NF90_REAL, dimids3, wvort_varid)
      retval = nf90_def_var(ncid, wsst_NAME, NF90_REAL, dimids3, wsst_varid)
      retval = nf90_def_var(ncid, wcur_NAME, NF90_REAL, dimids3, wcur_varid)
            
      retval = nf90_put_att(ncid, wc_varid, UNITS, wc_UNITS)
      retval = nf90_put_att(ncid, wc_varid, LNAME, wc_LNAME)
      retval = nf90_put_att(ncid, wvort_varid, UNITS, wvort_UNITS)
      retval = nf90_put_att(ncid, wvort_varid, LNAME, wvort_LNAME)
      retval = nf90_put_att(ncid, wsst_varid, UNITS, wsst_UNITS)
      retval = nf90_put_att(ncid, wsst_varid, LNAME, wsst_LNAME)
      retval = nf90_put_att(ncid, wcur_varid, UNITS, wcur_UNITS)
      retval = nf90_put_att(ncid, wcur_varid, LNAME, wcur_LNAME)

      retval = nf90_put_att(ncid, wc_varid,'missing_value', missing_value)
      retval = nf90_put_att(ncid, wvort_varid,'missing_value', missing_value)
      retval = nf90_put_att(ncid, wsst_varid,'missing_value', missing_value)
      retval = nf90_put_att(ncid, wcur_varid,'missing_value', missing_value)

      retval = nf90_enddef(ncid)

      retval = nf90_put_var(ncid, t_varid, T)
      retval = nf90_put_var(ncid, y_varid, Y)
      retval = nf90_put_var(ncid, x_varid, X)

      retval = nf90_put_var(ncid, wc_varid, wc)
      retval = nf90_put_var(ncid, wvort_varid, wvort)
      retval = nf90_put_var(ncid, wsst_varid, wsst)
      retval = nf90_put_var(ncid, wcur_varid, wcur)

      retval = nf90_close(ncid)

      return

      end subroutine
