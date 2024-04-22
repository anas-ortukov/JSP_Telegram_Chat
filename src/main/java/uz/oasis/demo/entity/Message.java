package uz.oasis.demo.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CurrentTimestamp;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class Message {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    private String text;
    @ManyToOne
    private User sender;
    @ManyToOne
    private User receiver;
    @CurrentTimestamp
    private LocalDateTime createdAt;

    public String showTime() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm a");
        return createdAt.format(formatter);
    }
}
