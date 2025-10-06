package org.example.iotplatform.dao;

import org.example.iotplatform.model.SensorReading;
import java.util.List;

public interface SensorReadingDAO {
    void addReading(SensorReading reading);
    List<SensorReading> getAllReadings();
    SensorReading getReadingById(String readingId);
    List<SensorReading> getReadingsBySensorId(String sensorId);
    List<SensorReading> getReadingsBySensorType(String sensorType);
}
