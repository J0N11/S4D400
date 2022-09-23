CLASS z17_dove DEFINITION INHERITING FROM Z17_BIRD PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS:

        constructor
            IMPORTING
                iv_volume type i
                iv_name type string,




        shit
            IMPORTING
                iv_person type ref to Z17_person,

        curr
            RETURNING
                VALUE(rv_curr) TYPE string.



  PROTECTED SECTION.



  PRIVATE SECTION.

    DATA lv_volume type i.

ENDCLASS.


CLASS z17_dove IMPLEMENTATION.
  METHOD curr.
      DO lv_volume times.
      rv_curr = 'sheeeeeeeeeeeeesh'.
        ENDDO.
  ENDMETHOD.

  METHOD shit.
       iv_person->set_pissed( abap_true ).
  ENDMETHOD.


  METHOD constructor.

    super->constructor( iv_name = iv_name ).
    lv_volume = iv_volume.

  ENDMETHOD.

ENDCLASS.
