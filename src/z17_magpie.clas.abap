CLASS z17_magpie DEFINITION INHERITING FROM Z17_BIRD PUBLIC FINAL CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
        constructor
            IMPORTING
            iv_name type string,
        steal
            IMPORTING
                iv_person TYPE ref to Z17_person
            EXCEPTIONS
                hungry
                no_items
                already_carrying_item,
         put_in_Nest.


  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA:
            lt_items TYPE STANDARD TABLE OF string with EMPTY KEY,
            lv_currentItem TYPE string.
ENDCLASS.



CLASS z17_magpie IMPLEMENTATION.
  METHOD steal.
    if lv_currentItem EQ ''.
      If Z17_animal~lv_is_hungry EQ abap_false.

        DATA(lv_itemsCount) = iv_person->countItems( ).
        if lv_itemsCount GT 0.
            DATA(lv_index) = cl_abap_random_int=>create( seed = CONV i( sy-uzeit )
                                      min  = 1
                                      max = lv_itemsCount )->get_next( ).


                   READ TABLE iv_person->lt_items INDEX lv_index INTO lv_currentItem.

              ELSE.
               RAISE no_items.
         ENDIF.
            ELSE.
                raise hungry.
       ENDIF.
        ELSE.
            raise already_carrying_item.
            ENDIF.
  ENDMETHOD.

  METHOD constructor.
    super->constructor( iv_name = iv_name ).
  ENDMETHOD.

  METHOD put_in_nest.
     lt_items = VALUE #( base lt_items ( lv_currentItem ) ).
  ENDMETHOD.

ENDCLASS.
