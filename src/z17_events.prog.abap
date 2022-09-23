*&---------------------------------------------------------------------*
*& Report z17_events
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z17_events.
DATA: events TYPE TABLE OF Z00_EVENTS,
      priceh TYPE p DECIMALS 2,
      pricek TYPE p DECIMALS 2,
      pricee TYPE p DECIMALS 2,
      time TYPE INT8,
      remainingDays TYPE INT8.


SELECT *
FROM Z00_EVENTS
WHERE event_date > @sy-datlo OR ( event_date = @sy-datlo AND start_time >= @sy-timlo )
INTO TABLE @events.

TRY.
    cl_salv_table=>factory(
        IMPORTING
          r_salv_table = DATA(alv)
        CHANGING
          t_table = events
      ).
  CATCH cx_root.
ENDTRY.

alv->display( ).

LOOP AT events REFERENCE INTO DATA(event).
CASE event->kind.
WHEN 'HB'.
priceh += 2 * event->price_adult + 1 * event->price_child.
WHEN 'KR'.
pricek += 3 * event->price_adult + 6 * event->price_child.
WHEN 'EH'.
pricee += 1 * event->price_adult + 4 * event->price_child.
ENDCASE.
time = ( event->end_time - event->start_time ) / 60.
remainingDays = event->event_date - sy-datlo.
WRITE: time, remainingDays, event->name.
ENDLOOP.
WRITE: priceh, pricek, pricee.

SELECT * FROM Z00_EVENTS WHERE event_date = '20230121' INTO TABLE @events.
