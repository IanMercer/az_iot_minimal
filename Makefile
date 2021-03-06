# Ideally there would be a .pc file in the azure_iot_sdks package
# but there isn't yet. If there was we could do this ...
#CFLAGS  = -Wall -Wextra -g `pkg-config --cflags azure_iot_sdks` -I/usr/include
CFLAGS  = -Wall -Wextra -g -I/usr/include -I/usr/include/azureiot

# This is all the pre-built libraries, remove the ones you don't need
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

