class z17_bird DEFINITION ABSTRACT PUBLIC CREATE PUBLIC .

  PUBLIC SECTION.

   INTERFACES Z17_ANIMAL.

        METHODS:
            constructor
                IMPORTING
                    iv_name TYPE string,
            fly_down
                IMPORTING
                    iv_height TYPE i
                EXCEPTIONS
                    fly_too_low
                    hungry,

            fly_up
                IMPORTING
                    iv_height TYPE i
                EXCEPTIONS
                    fly_too_high
                    hungry.







  PROTECTED SECTION.

        DATA:
                lv_span TYPE p LENGTH 6 DECIMALS 2,
                lv_height TYPE i.


  PRIVATE SECTION.




ENDCLASS.



CLASS z17_bird IMPLEMENTATION.
  METHOD fly_down.
    IF me->z17_animal~lv_is_hungry EQ abap_true.
      lv_height -= iv_height.

      If lv_height LT 0.
        RAISE fly_too_low.
      ENDIF.
      ELSE.
        RAISE hungry.
      ENDIF.

  ENDMETHOD.

  METHOD fly_up.

    IF me->z17_animal~lv_is_hungry EQ abap_true.

     lv_height += iv_height.

      If lv_height GT 0.
        RAISE fly_too_high.
     ENDIF.

     ELSE.
        RAISE hungry.
      ENDIF.

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

  ENDMETHOD.

  METHOD constructor.
    Z17_animal~lv_is_hungry = abap_false.
     Z17_animal~lv_name = iv_name.
  ENDMETHOD.

ENDCLASS.
