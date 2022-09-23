*&---------------------------------------------------------------------*
*& Report z17_sql1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z17_sql1.

DATA: gs_flight TYPE d400_s_flight.


PARAMETERS: p_carr TYPE d400_s_flight-carrid,
            p_flight TYPE d400_s_flight-connid,
            p_date TYPE d400_s_flight-fldate.

SELECT SINGLE FROM sflight
FIELDS carrid, connid, fldate, planetype, seatsmax, seatsocc
WHERE carrid = @p_carr AND connid = @p_flight AND fldate = @p_date
INTO @gs_flight.

WRITE: gs_flight-carrid,
       gs_flight-connid,
       gs_flight-fldate,
       gs_flight-planetype,
       gs_flight-seatsmax,
       gs_flight-seatsocc.
