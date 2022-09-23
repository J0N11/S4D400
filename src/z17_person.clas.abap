CLASS z17_person DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    DATA lt_items TYPE STANDARD TABLE OF string WITH EMPTY KEY.
    METHODS:
      constructor
        IMPORTING
          iv_name TYPE string,
      feed
        IMPORTING
          iv_animal TYPE REF TO Z17_animal
          iv_food   TYPE string,

      curse
        IMPORTING
          iv_curse        TYPE string
        RETURNING
          VALUE(rv_curse) TYPE string,

      set_pissed
        IMPORTING
          iv_is_pissed TYPE abap_bool,
      get_name
        RETURNING
          VALUE(iv_name) TYPE string,
      add_item
        IMPORTING
          iv_item TYPE string,

      countItems
        RETURNING
          VALUE(rv_count) TYPE i.





  PROTECTED SECTION.


  PRIVATE SECTION.

    DATA: lv_name      TYPE c LENGTH 20,
          lv_is_pissed TYPE abap_boolean.



ENDCLASS.


CLASS z17_person IMPLEMENTATION.
  METHOD constructor.

    lv_name = iv_name.
    lv_is_pissed = abap_false.

  ENDMETHOD.

  METHOD curse.

    IF lv_is_pissed EQ abap_true.
      rv_curse = iv_curse.
    ELSE.
      rv_curse = 'Anyways... FREU!'.

    ENDIF.

  ENDMETHOD.

  METHOD feed.

    IF lv_is_pissed EQ abap_false.
      iv_animal->eat( iv_food ).

    ENDIF.

  ENDMETHOD.

  METHOD set_pissed.
    lv_is_pissed = iv_is_pissed.
  ENDMETHOD.

  METHOD get_name.
    iv_name = lv_name.
  ENDMETHOD.

  METHOD add_item.
    lt_items = VALUE #( BASE lt_items ( iv_item ) ).
  ENDMETHOD.

  METHOD countitems.
    "DESCRIBE TABLE lt_items LINES rv_count.
    rv_count = lines( lt_items ).
  ENDMETHOD.

ENDCLASS.
