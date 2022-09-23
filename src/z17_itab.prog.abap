*&---------------------------------------------------------------------*
*& Report z17_itab
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z17_itab.

DATA: gt_connections TYPE z17_t_connections,
      gt_flights TYPE d400_t_flights,
      gt_percentage TYPE d400_t_percentage.

gt_connections = VALUE #( ( carrid = 'LH' connid = '0400' )
                          ( carrid = 'LH' connid = '0401' ) ).

CALL FUNCTION 'Z_00_GET_FLIGHTS_FOR_CONNECT'
    EXPORTING
        it_connections = gt_connections
    IMPORTING
        et_flights = gt_flights.

gt_percentage = CORRESPONDING #( gt_flights ).

LOOP AT gt_percentage REFERENCE INTO DATA(gs_percentage).
IF gs_percentage->seatsmax IS NOT INITIAL.
gs_percentage->percentage = gs_percentage->seatsocc / gs_percentage->seatsmax * 100.
ENDIF.
ENDLOOP.
TRY.
    cl_salv_table=>factory(
        IMPORTING
          r_salv_table = DATA(alv)
        CHANGING
          t_table = gt_percentage
      ).
  CATCH cx_root.
ENDTRY.

alv->display( ).
