*&---------------------------------------------------------------------*
*& Report z17_structure
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z17_structure.

TYPES: BEGIN OF ts_complete,
 carrid TYPE d400_struct_s1-carrid,
 connid TYPE d400_struct_s1-connid,
 cityfrom TYPE d400_struct_s1-cityfrom,
 cityto TYPE d400_struct_s1-cityto,
 fldate TYPE d400_s_flight-fldate,
 planetype TYPE d400_s_flight-planetype,
 seatsmax TYPE d400_s_flight-seatsmax,
 seatsocc TYPE d400_s_flight-seatsocc,
 END OF ts_complete.


DATA: gs_conn TYPE z17_connection,
      gs_flight TYPE d400_s_flight.

gs_conn = VALUE #( carrid = 'LH'
                   connid = '0400'
                   cityfrom = 'Frankfurt'
                   cityto = 'New York' ).
CALL FUNCTION 'Z_00_GET_NEXT_FLIGHT'
    EXPORTING
        iv_carrid = gs_conn-carrid
        iv_connid = gs_conn-connid
    IMPORTING
        es_flight = gs_flight
    EXCEPTIONS
        no_data.
DATA gs_complete TYPE ts_complete.
gs_complete = CORRESPONDING #( BASE ( gs_complete ) gs_flight ).
gs_complete = CORRESPONDING #( BASE ( gs_complete ) gs_conn ).
WRITE: gs_complete-carrid,
       gs_complete-cityfrom,
       gs_complete-cityto,
       gs_complete-connid,
       gs_complete-fldate,
       gs_complete-planetype,
       gs_complete-seatsmax,
       gs_complete-seatsocc.
