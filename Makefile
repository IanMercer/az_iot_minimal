
# Missing a .PC file for the Azure_iot_sdks
#CFLAGS  = -Wall -Wextra -g `pkg-config --cflags azure_iot_sdks` -I/usr/include
CFLAGS  = -Wall -Wextra -g -I/usr/include -I/usr/include/azureiot

#LIBS = -lm `pkg-config --libs azure_iot_sdks` -lssl -lcrypto
LIBS = -lm -lssl -lcrypto -lpthread -lcurl \
/usr/lib/libiothub_client.a \
/usr/lib/libiothub_client_amqp_transport.a \
/usr/lib/libiothub_client_amqp_ws_transport.a \
/usr/lib/libiothub_client_http_transport.a \
/usr/lib/libiothub_client_mqtt_transport.a \
/usr/lib/libiothub_client_mqtt_ws_transport.a \
/usr/lib/libiothub_service_client.a \
/usr/lib/libparson.a \
/usr/lib/libserializer.a \
/usr/lib/libuamqp.a \
/usr/lib/libuhttp.a \
/usr/lib/libumock_c.a \
/usr/lib/libumqtt.a \
/usr/lib/libaziotsharedutil.a

main : main.c
	gcc -g3 -o main main.c $(CFLAGS) $(LIBS) -DUSE_OPENSSL


