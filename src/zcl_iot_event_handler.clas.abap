class ZCL_IOT_EVENT_HANDLER definition
  public
  inheriting from CL_REST_HTTP_HANDLER
  final
  create public .

public section.

  methods IF_REST_APPLICATION~GET_ROOT_HANDLER
    redefinition .
protected section.

  methods HANDLE_CSRF_TOKEN
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_IOT_EVENT_HANDLER IMPLEMENTATION.


  method HANDLE_CSRF_TOKEN.
*CALL METHOD SUPER->HANDLE_CSRF_TOKEN
*  EXPORTING
*    IO_CSRF_HANDLER =
*    IO_REQUEST      =
*    IO_RESPONSE     =
*    .
  endmethod.


  method IF_REST_APPLICATION~GET_ROOT_HANDLER.
    DATA(handler) = new cl_rest_router( ).

    handler->attach( iv_template = '/trigger'  iv_handler_class = 'ZCL_IOT_EVENT_RESOURCE' ).

    ro_root_handler = handler.

  endmethod.
ENDCLASS.
