package uz.oasis.demo.repo;

import uz.oasis.demo.entity.Message;
import uz.oasis.demo.entity.User;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class MessageRepo extends BaseRepo<Message, UUID> {


    public List<Message> getConversation(User sender, UUID receiver) {
        List<Message> messages = new ArrayList<>();
        for (Message message : findAll()) {
            if ((message.getSender().equals(sender) && message.getReceiver().getId().equals(receiver)) ||
                    (message.getReceiver().getId().equals(sender.getId()) && message.getSender().getId().equals(receiver))) {
                messages.add(message);
            }
        }
        return messages;
    }
}
