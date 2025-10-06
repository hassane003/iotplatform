package org.example.iotplatform.controller;

import org.example.iotplatform.dao.InMemorySensorReadingDAO;
import org.example.iotplatform.dao.SensorReadingDAO;
import org.example.iotplatform.model.SensorReading;
import org.example.iotplatform.service.IoTSensorManagerService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/iot-dashboard")
public class IoTSensorControllerServlet extends HttpServlet {

    private IoTSensorManagerService iotSensorManagerService;

    @Override
    public void init() throws ServletException {
        SensorReadingDAO dao = new InMemorySensorReadingDAO();
        this.iotSensorManagerService = new IoTSensorManagerService(dao);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("readings", iotSensorManagerService.retrieveAllSensorReadings());
        request.getRequestDispatcher("/WEB-INF/views/iot-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String sensorId   = req.getParameter("sensorId");
        String sensorType = req.getParameter("sensorType");
        String valueStr   = req.getParameter("value");
        String unit       = req.getParameter("unit");
        String location   = req.getParameter("location");

        double value = 0.0;
        try { value = Double.parseDouble(valueStr); } catch (Exception ignored) {}

        SensorReading reading = new SensorReading(
                UUID.randomUUID().toString(),
                sensorId, sensorType, value, unit,
                System.currentTimeMillis(),
                location
        );
        iotSensorManagerService.ingestSensorReading(reading);
        resp.sendRedirect(req.getContextPath() + "/iot-dashboard");
    }
}