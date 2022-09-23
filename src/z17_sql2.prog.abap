*&---------------------------------------------------------------------*
*& Report z17_sql2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z17_sql2.

DATA: gt_flights TYPE d400_t_flights.

PARAMETERS: ev_carr TYPE d400_s_flight-carrid,
            ev_conn TYPE d400_s_flight-connid.

SELECT FROM sflight
FIELDS carrid, connid, fldate, planetype, seatsmax, seatsocc
WHERE carrid = @ev_carr AND connid = @ev_conn
INTO TABLE @gt_flights.
TRY.
cl_s4d_output=>display_table( it_table = gt_flights ).
CATCH cx_root.
ENDTRY.
