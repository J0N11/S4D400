*&---------------------------------------------------------------------*
*& Report z17_inzest
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z17_inzest.


DATA: go_magpie TYPE REF TO Z17_magpie,
      go_person type ref to Z17_person,
      go_shark type REF TO Z17_shark,
      go_elephant type REF TO Z17_elephant,
      go_elephant2 type REF TO Z17_elephant,
      go_dove type REF TO Z17_dove.


        go_magpie = new #( 'JONATHAN' ).
        go_person = new #( 'ENZO' ).
        go_shark = new #( iv_name = 'MANUEL' iv_teeth = 100 ).
        go_elephant = new #( iv_name = 'HENDRICK' gender = 'm' lv_color ='pink' ).
        go_elephant = new #( iv_name = 'HENDRICK' gender = 'f' lv_color ='pink' ).
        go_dove = new #( iv_name = 'MAURICE' iv_volume = 100 ).
