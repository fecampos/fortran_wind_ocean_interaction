      subroutine angles(nx,ny,pi,missing_val,ux,uy,angle)

      implicit none

      integer, intent(in) :: nx, ny

      real,intent(in) :: ux(nx,ny), uy(nx,ny), missing_val, pi

      real, intent(out) :: angle(nx,ny)

      angle = missing_val

      where ((ux.ne.missing_val).and.(uy.ne.missing_val))
        angle = atan(uy,ux)
      end where

!      where ((ux.ne.missing_val).and.(uy.ne.missing_val).and.(ux.gt.0).and.(uy.gt.0))
!        angle = atan(uy,ux)
!      elsewhere ((ux.ne.missing_val).and.(uy.ne.missing_val).and.(ux.lt.0).and.(uy.gt.0))
!        angle = atan(uy,ux)+pi/2
!      elsewhere ((ux.ne.missing_val).and.(uy.ne.missing_val).and.(ux.lt.0).and.(uy.lt.0))
!        angle = atan(uy,ux)+pi
!      elsewhere ((ux.ne.missing_val).and.(uy.ne.missing_val).and.(ux.gt.0).and.(uy.lt.0))
!        angle = atan(uy,ux)+1.5*pi
!      end where

      end subroutine
