public class ControllerHelper {
   private Map<String, List<String>> mapCallLine;

    public ControllerHelper(Map<String, List<String>> initialData) {
        mapCallLine = initialData != null ? new Map<String, List<String>>(initialData) : new Map<String, List<String>>();
    }

    public void addCallId(String callLineName, String callId) {
        if (!mapCallLine.containsKey(callLineName)) {
            mapCallLine.put(callLineName, new List<String>());
        }
        mapCallLine.get(callLineName).add(callId);
    }

    public List<String> getCallIds(String callLineName) {
        return mapCallLine.containsKey(callLineName) ? mapCallLine.get(callLineName) : new List<String>();
    }
}