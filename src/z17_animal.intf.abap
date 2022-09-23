interface Z17_ANIMAL
public.
  DATA:
       lv_name TYPE c LENGTH 20,
       lv_is_hungry TYPE abap_bool,
       lv_gender type c LENGTH 1,
       lv_color type c LENGTH 20,
       lt_food type STANDARD TABLE OF string with EMPTY KEY.


    METHODS:
        eat
            IMPORTING
                iv_food TYPE string
            EXCEPTIONS
                wrong_food,
        move
            EXCEPTIONS
                hungry,
        sleep
            EXCEPTIONS
                hungry.




endinterface.
