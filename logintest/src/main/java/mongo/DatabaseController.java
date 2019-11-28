package mongo;

import com.mongodb.MongoClient;
import com.mongodb.DBCollection;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.DBCursor;
import org.bson.types.ObjectId;
import java.util.ArrayList;

public class DatabaseController {
    
    private MongoClient client = null;
    private final String ip = "localhost";
    
    /**
     * Connects to a MongoDB server at the given address.
     */
    public void connect()
    {
        try
        {
            client = new MongoClient(this.ip, 27017);
            
            if(client != null)
            {
                System.out.printf("Connected to %s\n", ip);
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
    
    /**
     * Closes the connection with the MongoDB server if one was opened.
     */
    public void close()
    {
        if(client == null)
        {
            System.out.println("Connection not established before calling close().");
            return;
        }
        
        client.close();
        client = null;
    }
    
    /**
     * Adds a new form entry to the "published_forms" collection and creates
     * a new collection to hold the submissions for the new  form.
     * 
     * @param url   the unique URL associated with this form
     * @param json  the entirety of the JSON code representing the layout of the form
     */
    public void addNewForm(String url, String json)
    {
        DBCollection col = null;
        BasicDBObject obj = null;
        
        if(client == null)
        {
            System.out.println("Connection not established before trying to publish form.");
            return;
        }
        
        col = client.getDB("forms").getCollection("published_forms");
        obj = new BasicDBObject();
        
        obj.put("unique_url", url);
        obj.put("form_json", json);
        
        System.out.println("adding form " + url);
        col.insert(obj);
    }
    
    /**
     * Adds a new submission entry to the collection mapped to by the unique URL.
     * 
     * @param url               the unique URL of the form the submission is for
     * @param json              the entirety of the JSON representing the layout 
     *                          of the form and what was put into each field
     * @param submissionNumber  the index for the new submission
     */
    public void addSubmission(String url, String json)
    {
        DBCollection col = null;
        BasicDBObject sub = null;
        int subcount;
        
        if(client == null)
        {
            System.out.println("Connection not established before trying to add submission.");
            return;
        }
        
        col = client.getDB("forms").getCollection(url);
        sub = new BasicDBObject();
        subcount = (int)col.count() + 1;
        
        sub.put("number", subcount);
        sub.put("json", json);
        //ObjectId id = (ObjectId)sub.get("_id");
        //System.out.println("added submission");
        //System.out.println(id.toString());
        col.insert(sub);
    }
    
    /**
     * Get the last form in the database. This *should* be the most recent form created.
     * 
     * @return the unique URL of the last form in the database
     */
    public String getLastForm()
    {
        DBCollection col = null;
        BasicDBObject form = null;
        DBCursor cursor = null;
        String url = null;
        
        if(client == null)
        {
            System.out.println("Connecrtion not established before trying to get last form.");
            return null;
        }
        
        col = client.getDB("forms").getCollection("published_forms");
        cursor = col.find();
        
        while(cursor.hasNext())
        {
            form = (BasicDBObject)cursor.next();
            url = form.getString("unique_url");
        }
        
        return url;
    }
    
    public ArrayList<String> getAllFormURLS()
    {
        DBCollection col = null;
        BasicDBObject form = null;
        DBCursor cursor = null;
        String url = null;
        ArrayList<String> urls = new ArrayList<String>();
        
        if(client == null)
        {
            System.out.println("Connecrtion not established before trying to get last form.");
            return null;
        }
        
        col = client.getDB("forms").getCollection("published_forms");
        cursor = col.find();
        
        int i = 0;
        while(cursor.hasNext())
        {
            form = (BasicDBObject)cursor.next();
            url = form.getString("unique_url");
            urls.add("\"" + url + "\"");
            System.out.printf("url added: %s\n", url);
            i++;
        }
        
        return urls;
    }
    
    public String getSubmissionJson(String url, int sub)
    {
        DBCollection col = null;
        DBObject query = null;
        DBCursor cursor = null;
        String json = null;
        
        if(client == null)
        {
            System.out.println("Connection not established before trying to get a form.");
            return null;
        }
        
        col = client.getDB("forms").getCollection(url);
        
        query = new BasicDBObject();
        query.put("number", sub);
        cursor = col.find(query);
        
        while(cursor.hasNext())
        {
            BasicDBObject result = (BasicDBObject)cursor.next();
            json = result.getString("json");
        }
        
        return json;
    }
    
    public String getFormJson(String url)
    {
        DBCollection col = null;
        DBObject query = null;
        DBCursor cursor = null;
        String json = null;
        
        if(client == null)
        {
            System.out.println("Connection not established before trying to get a form.");
            return null;
        }
        
        col = client.getDB("forms").getCollection("published_forms");
        
        query = new BasicDBObject();
        query.put("unique_url", url);
        cursor = col.find(query);
        
        while(cursor.hasNext())
        {
            BasicDBObject result = (BasicDBObject)cursor.next();
            json = result.getString("form_json");
        }
        
        return json;
    }
    
    /**
     * Deletes a form and all of its submissions from the database.
     * 
     * @param url the unique URL of the form to delete
     */
    public void deleteForm(String url)
    {
        DBCollection col = null;
        DBObject query = null;
        DBCursor cursor = null;
        
        if(client == null)
        {
            System.out.println("Connection not established before trying to delete form.");
            return;
        }
        
        // Drop the collection of submissions from the database
        col = client.getDB("forms").getCollection(url);
        col.drop();
        
        // Remove the entry for the form from the "published_forms" collection
        col = client.getDB("forms").getCollection("published_forms");
        
        query = new BasicDBObject();
        query.put("unique_url", url);
        cursor = col.find(query);
        
        while(cursor.hasNext())
        {
            DBObject result = cursor.next();
            col.remove(result);
        }
    }
    
    /**
     * Delete a single entry from the collection of submissions associated
     * with the given unique URL.
     * 
     * @param url               the unique URL of the form to delete the submission from
     * @param submissionNumber  the specific submission number to delete
     */
    public void deleteSubmission(String url, int submissionNumber)
    {
        BasicDBObject obj = null;
        DBCollection col = null;
        
        if(client == null)
        {
            System.out.println("Connection not established before trying to delete submission.");
            return;
        }
        
        col = client.getDB("forms").getCollection(url);
        obj = new BasicDBObject();
        
        obj.put("number", submissionNumber);
        col.remove(obj);
    }
    
    /**
     * Count the number of submissions that the form associated with the given
     * URL currently has.
     * 
     * @param url   the unique URL of the form to count the submissions for
     * @return      the number of submissions in the form
     */
    public long countSubmissions(String url)
    {
        DBCollection col = null;
        
        if(client == null)
        {
            System.out.println("Connection not established before trying to count submissions.");
            return -1;
        }
        
        col = client.getDB("forms").getCollection(url);
        return col.count();
    }
    
    public long countForms()
    {
        DBCollection col = null;
        
        if(client == null)
        {
            System.out.println("Connection not established before trying to count forms.");
            return -1;
        }
        
        col = client.getDB("forms").getCollection("published_forms");
        return col.count();
    }
    
    /**
     * Check if there is a form that already exists with the given URL.
     * 
     * @param url   the unique URL to check against the database
     * @return      whether that URL is already in the database or not
     */
    public boolean checkIfExists(String url)
    {
        DBCollection col = null;
        DBObject query = null;
        DBCursor cursor = null;
        
        if(client == null)
        {
            System.out.println("Connection not established before trying to check if a URL exists.");
            return false;
        }
        
        col = client.getDB("forms").getCollection("published_forms");
        
        query = new BasicDBObject();
        query.put("unique_url", url);
        cursor = col.find(query);
        
        if(cursor.count() == 0)
        {
            return false;
        }
        
        return true;
    }
    
    /**
     * Get the object for the database that this class uses.
     * 
     * @return the MongoDB MongoClient object that this class uses
     */
    public MongoClient getClient()
    {
        return client;
    }
}