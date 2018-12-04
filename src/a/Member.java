
package a;

public class Member {

	/*id   
	 * | password   
	 * | first_name 
	 * | last_name          
	 * | address         
	 * | age  
	 * | job             
	 * | sex  
	 * | phone_number  
	 * | email            
	 * | smoney 
	 * | shinsegae_point 
	 * | spocket*/
	
	public String id;
	public String password;
	public String first_name;
	public String last_name;
	public String address;
	public String age;
	public String job;
	public String sex;
	public String phone_number;
	public String email;
	public int smoney = 0;
	public int shinsegae_point = 0;
	public int spocket = 0;
	
	public String makeQ()
	{
		String query = "INSERT INTO customer VALUES"
				+ "('"
				+ id + "','"
				+ password + "'";
		
		if(first_name.isEmpty())
		{
			query = query + ",NULL";
		}
		else
		{
			query = query + ",'" + first_name + "'";
		}
		
		if(last_name.isEmpty())
		{
			query = query + ",NULL";
		}
		else
		{
			query = query + ",'" + last_name + "'";
		}
		
		if(address.isEmpty())
		{
			query = query + ",NULL";
		}
		else
		{
			query = query + ",'" + address + "'";
		}
		
		if(age.isEmpty())
		{
			query = query + ",NULL";
		}
		else
		{
			query = query + ",'" + age + "'";
		}
		
		if(job.isEmpty())
		{
			query = query + ",NULL";
		}
		else
		{
			query = query + ",'" + job + "'";
		}
		if(sex.isEmpty())
		{
			query = query + ",NULL";
		}
		else
		{
			query = query + ",'" + sex + "'";
		}		
		if(phone_number.isEmpty())
		{
			query = query + ",NULL";
		}
		else
		{
			query = query + ",'" + phone_number + "'";
		}			
		if(email.isEmpty())
		{
			query = query + ",NULL";
		}
		else
		{
			query = query + ",'" + email + "'";
		}			

		query = query + "," + smoney;
		query = query + "," + shinsegae_point;
		query = query + "," + spocket + ");";
		
		
		return query;
	}
}
