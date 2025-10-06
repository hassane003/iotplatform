package org.example.iotplatform.dao;

import org.example.iotplatform.model.SensorReading;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

public class InMemorySensorReadingDAO implements SensorReadingDAO {

    private final Map<String, SensorReading> store = new ConcurrentHashMap<>();

    @Override
    public void addReading(SensorReading reading) {
        store.put(reading.getReadingId(), reading);
    }

    @Override
    public List<SensorReading> getAllReadings() {
        return new ArrayList<>(store.values());
    }

    @Override
    public SensorReading getReadingById(String readingId) {
        return store.get(readingId);
    }

    @Override
    public List<SensorReading> getReadingsBySensorId(String sensorId) {
        return store.values().stream()
                .filter(r -> Objects.equals(r.getSensorId(), sensorId))
                .collect(Collectors.toList());
    }

    @Override
    public List<SensorReading> getReadingsBySensorType(String sensorType) {
        return store.values().stream()
                .filter(r -> Objects.equals(r.getSensorType(), sensorType))
                .collect(Collectors.toList());
    }
}
