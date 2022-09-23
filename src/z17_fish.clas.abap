CLASS z17_fish DEFINITION ABSTRACT PUBLIC CREATE PUBLIC.

    PUBLIC SECTION.
    INTERFACES Z17_ANIMAL.
    METHODS:
    constructor
    IMPORTING
        iv_name TYPE string,
    m_dive_down
    IMPORTING
    iv_metersdown TYPE i
        EXCEPTIONS
            hungry,

    m_dive_up
    IMPORTING
    iv_metersup TYPE i
        EXCEPTIONS
            hungry.
  PROTECTED SECTION.
    DATA: lv_vegetarian TYPE abap_bool,
          lv_depht TYPE i.
  PRIVATE SECTION.
ENDCLASS.

CLASS z17_fish IMPLEMENTATION.
    METHOD constructor.
     Z17_animal~lv_is_hungry = abap_false.
     Z17_animal~lv_name = iv_name.
  ENDMETHOD.
    METHOD m_dive_down.
        IF lv_depht - iv_metersdown < -200.
        RAISE hungry.
           WRITE 'Die maximale Tauchtiefe des Fisches ist -200 Meter'.
           EXIT.
        ENDIF.
        lv_depht = lv_depht - iv_metersdown.
    ENDMETHOD.
    METHOD m_dive_up.
        RAISE hungry.
        IF lv_depht + iv_metersup > 0.
           WRITE 'Der Fisch kann nicht Fliegen'.
           EXIT.
        ENDIF.
        lv_depht = lv_depht + iv_metersup.
    ENDMETHOD.
  METHOD z17_animal~eat.
     LOOP AT z17_animal~lt_food INTO DATA(s_food).
      IF s_food = iv_food.
        z17_animal~lv_is_hungry = abap_false.
        RETURN.
      ENDIF.
    ENDLOOP.
    RAISE wrong_food.
  ENDMETHOD.

  METHOD z17_animal~move.
    IF z17_animal~lv_is_hungry EQ abap_true.
        RAISE hungry.
    ENDIF.
    z17_animal~lv_is_hungry = abap_true.
  ENDMETHOD.

  METHOD z17_animal~sleep.
    IF z17_animal~lv_is_hungry EQ abap_false.
        z17_animal~lv_is_hungry = abap_true.
    ELSE.
        RAISE hungry.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
