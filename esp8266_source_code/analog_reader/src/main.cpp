#include <Arduino.h>
#include <iostream>
using namespace std;

#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>

// SSID & Password
const char *ssid = "NodeMCU";
const char *password = "123456789";

// server is gonna listen on port 80
ESP8266WebServer server(80);

const int analogPin = A0;

void handleOnConnect();

void setup()
{
  Serial.begin(115200);
  WiFi.softAP(ssid, password);

  IPAddress myIP = WiFi.softAPIP();
  Serial.print("Access Point IP:");
  Serial.println(myIP);

  server.begin();
  Serial.println("HTTP Server Started...");

  server.on("/read", handleOnConnect);
}

void loop()
{
  server.handleClient();
}

void handleOnConnect()
{
  Serial.println("connected");
  int sensorValue = analogRead(analogPin);
  std::string s = std::to_string(sensorValue);
  char const *pchar = s.c_str();
  server.send(200, "application/json", pchar);
}