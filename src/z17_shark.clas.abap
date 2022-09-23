CLASS z17_shark DEFINITION INHERITING FROM z17_fish PUBLIC CREATE PUBLIC FINAL.

  PUBLIC SECTION.

    METHODS:
        constructor
        IMPORTING
            iv_name TYPE string
            iv_teeth TYPE i,
        m_bite
        IMPORTING
            iv_person TYPE REF TO Z17_PERSON.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA lv_Teeth TYPE i.
ENDCLASS.

CLASS z17_shark IMPLEMENTATION.
    METHOD constructor.
        super->constructor( iv_name = iv_name ).
        lv_Teeth = iv_teeth.
    ENDMETHOD.
    METHOD m_bite.
        Z17_ANIMAL~lv_is_hungry = abap_false.
        iv_person->set_pissed( abap_true ).
    ENDMETHOD.
ENDCLASS.
