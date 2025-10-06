package org.example.iotplatform.service;

import org.example.iotplatform.dao.SensorReadingDAO;
import org.example.iotplatform.model.SensorReading;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

public class IoTSensorManagerService {

    private final SensorReadingDAO sensorReadingDAO;

    public IoTSensorManagerService(SensorReadingDAO sensorReadingDAO) {
        this.sensorReadingDAO = sensorReadingDAO;
    }

    public void ingestSensorReading(SensorReading reading) {
        sensorReadingDAO.addReading(reading);
    }

    public List<SensorReading> retrieveAllSensorReadings() {
        return sensorReadingDAO.getAllReadings();
    }

    public SensorReading findReadingById(String readingId) {
        return sensorReadingDAO.getReadingById(readingId);
    }

    public List<SensorReading> filterReadingsBySensorType(String sensorType) {
        return sensorReadingDAO.getReadingsBySensorType(sensorType);
    }

    public List<SensorReading> getLatestReadings(int limit) {
        return sensorReadingDAO.getAllReadings().stream()
                .sorted(Comparator.comparingLong(SensorReading::getTimestamp).reversed())
                .limit(limit)
                .collect(Collectors.toList());
    }
}