/*
 * inputChecks.java
 * 
 * This class contains generic checks used for the various labs
 * that will need to be graded across the two courses of chemistry.
 * It also has containers that stores various relevant data and
 * metadata for the labs.
 * 
 */

package Labs;

public class inputChecks 
{    
    protected int dataX; //number of rows
    protected int dataY; //number of columns
    protected String data[][]; //stores lab data inputed by the student
    protected String error[][]; //stores error messages
    protected String type[][]; //stores data type; used in front end
    protected String isCorrect[][]; //keeps track of correctness of data; stores HTML values for front end
    protected String key[][]; //stores correct answers for the lab
    protected String grade[][]; //stores the grade values
    protected String errorTypes[] = new String[]{"s.f. error", "calculation error", "unit error", "error"}; //container for error types
    protected String errorMsg = "&#10007;"; //✗ (hex: &#x2717; / dec: &#10007;): ballot x
    protected String correctMsg = "&#10004;"; // ✔ (hex: &#x2714; / dec: &#10004;): heavy check mark
    protected String tableName; //stores the name of the data table
    
    //private DataLoader load;
    //private DataPersister save;
    
    //constructor that also calls initData()
	public inputChecks(String tableName, int X, int Y, 
			String userid, String courseid, int labNumber)
    {
        dataX = X;
        dataY = Y;
        //load = new DataLoader();
        //save = new DataPersister();
        
        data = new String[dataX][dataY]; //stores lab data
        error = new String[dataX][dataY]; //stores error messages
        isCorrect = new String[dataX][dataY]; //keeps track of correct answers
        key = new String[dataX][dataY]; //answer key
        grade = new String[dataX][dataY]; //the grade given for each correct answer

        
        //String tempData = "108, , ,22, , ,33.43,g,4,39.87,g,4,33.5237,g,6,0.5319,g,4,0.5321,g,4,0.5321,g,4,0.9067,g,4,0.4145,g,4,0.5320,g,4,0.4922,g,4";
        String tempData = "49, ,25.809,g,25.0,mL,34.0,mL,50, ,24.90,mL,29.90,mL,34.85,mL,39.95,mL,44.4,mL,48.2860,g,53.4460,g,58.6430,g,63.9910,g,68.6720,g,9.0,mL,2.9,g/mL,5.00,mL,9.95,mL,15.05,mL,19.50,mL,5.160,g,10.357,g,15.705,g,20.386,g,1.03,g/mL";
        //String tempData = "";
        //tempData = load.restoreLab(tableName, labNumber, userid, courseid); //get lab data
        
        initData(tempData);
    }

    //parses string of submitted user data and stores it within data[][] array
    private void initData(String tempData)
    {
    	String temp = "";
    	
        for(int i = 0; i < dataX; ++i)
        {
            for(int j = 0; j < dataY; ++j)
            {
                //get substring
            	while(tempData.length() > 0 && !tempData.substring(0,1).equals(","))
                {
                    temp += tempData.substring(0,1);
                    tempData = tempData.substring(1);
                }
                
            	//remove comma
                if(tempData.length() > 0 && tempData.substring(0,1).equals(","))
                {
                    tempData = tempData.substring(1);
                }
                
                if(temp.length() > 0)
                {
                    data[i][j] = temp.trim();
                }
                else
                {
                    data[i][j] = "";
                }
                
                error[i][j] = "";
                isCorrect[i][j] = "";
                //type[i][j] = "";
                key[i][j] = "";
                grade[i][j] = "0.0";
                temp = "";
            }
        } 
    }
    
    public int getDataX()
    {
    	return dataX;
    }
    
    public int getDataY()
    {
    	return dataY;
    }
    
    public void setData(int x, int y, String info)
    {
        data[x][y] = info;
    }
    
    public String getData(int x, int y)
    {
        return data[x][y];
    }
    
    public void setType(int x, int y, String info)
    {
        type[x][y] = info;
    }
    
    public String getType (int x, int y)
    {
        return type[x][y];
    }
    
    public void setError(int x, int y, String info)
    {
        error[x][y] = info;
    }
    
    public String getError(int x, int y)
    {
        return error[x][y];
    }
    
    public void setIsCorrect(int x, int y, String info)
    {
    	isCorrect[x][y] = info;
    }
    
    public String getIsCorrect(int x, int y)
    {
        return isCorrect[x][y];
    }
    
    public void setGrade(int x, int y, String info)
    {
    	grade[x][y] = info;
    }
    
    public String getGrade(int x, int y)
    {
    	return grade[x][y];
    }
    
    public void setKey(int x, int y, String info)
    {
        key[x][y] = info;
    }
    
    public String getKey(int x, int y)
    {
        return key[x][y];
    }
    
    public void setTableName(String t)
    {
    	tableName = t;
    }
    
    public String getTableName()
    {
    	return tableName;
    }
    
    //checks if the input is a standard unit
    protected void unitStandard (int x, int y)
    {
        String temp;
        temp = data[x][y].toUpperCase();
        temp = temp.trim();
        
        if (temp.equals("G"))
        {
            temp = "g";
        }
        else if (temp.equals("MG"))
        {
            temp = "mg";
        }
        else if (temp.equals("KG"))
        {
            temp = "kg";
        }
        else if (temp.equals("L"))
        {
            temp = "L";
        }
        else if (temp.equals("ML"))
        {
            temp = "mL";
        }
        else if (temp.equals("CM"))
        {
            temp = "cm";
        }
        else if (temp.equals("M"))
        {
            temp = "m";
        }
        else if (temp.equals("KM"))
        {
            temp = "km";
        }
        else if (temp.equals("LB"))
        {
            temp = "lb";
        }
        else if (temp.equals("OZ"))
        {
            temp = "oz";
        }
        else if (temp.equals("CM"))
        {
            temp = "cm";
        }
        else if (temp.equals("S"))
        {
            temp = "s";
        }
        else if (temp.equals("IN"))
        {
            temp = "in";
        }
        else if (temp.equals("FT"))
        {
            temp = "ft";
        }
        else
        {
            temp = "";
        }
        
        if (temp.equals(""))
        {
            error[x][y] = "Invalid unit: \"" + data[x][y] + "\"";
            data[x][y] = "";
        }
        else
        {
            data[x][y] = temp;
        }
    }
    
    //checks if there are multiple decimal points
    protected void doubleStandard(int x, int y)
    {
        String temp = data[x][y];
        boolean hasDot = false;
        
        //check for numbers and . only
        //check for multiple .        
        for(int i = 0; i < temp.length(); i++)
        {
            if(temp.charAt(i) == '.')
            {
                if(hasDot)
                {
                	error[x][y] = "Invalid character: '.'";
                	data[x][y] = "";
                	return;
                }
                else
                {
                    hasDot = true;
                }
            }
            
            //check if there is a non-number character
            if (temp.charAt(i) != '.' && (int)temp.charAt(i) < 48 || (int)temp.charAt(i) > 57)
            {
                error[x][y] = "Invalid character: '" + temp.charAt(i) + "'";
                data[x][y] = "";
                return;
            }
        }
    }
    
    //checks for invalid characters
    protected void integerStandard (int x, int y)
    {
        String temp = data[x][y];        
                
        for(int i = 0; i < temp.length(); i++)
        {
            if((int)temp.charAt(i) < 48 || (int)temp.charAt(i) > 57)
            {
                error[x][y] = "Invalid character: '" + temp.charAt(i) + "'";
                data[x][y] = "";
                return;
            }
        }
    }
    
    public static String setSigFigs(String x, int numberSF)
    {
    	int a = 0;
    	int b = 0;
        int lastDigit;
    	int L =  x.length();
        boolean roundUp;
        String roundedLast;
    	
    	for(int i = 0; i < L; i++) //counts all chars except decimal
    	{
    		if(x.charAt(i) == '.')
    		{
    			a = i; //a = position of decimal
    		}
    		else
    		{
    			b++;
    		}
    	}
    	
    	if(a == 1 && x.charAt(0) == '0') //removes zeroes between dec and 1st non-zero digit in cases starting with "0."
    	{
    		int c = 2;
    		b--;
    		
    		while(x.charAt(c) == '0')
    		{
    			b--;
    			c++;
    		}
    	}

    	while(b != numberSF)
    	{
    		if(b < numberSF)
    		{
    			x += '0'; //adds a '0' to end of string
    			b++;
    		}
    		else
    		{
    			lastDigit = Character.getNumericValue(x.charAt(x.length()-1));
                        
                if(lastDigit > 4)
                {
                	roundUp = true;
                }
                else
                {
                	roundUp = false;
                }
                
                x = x.substring(0, x.length() - 1);	//deletes last char in string
                        
                L--;
                b--;
                            
                if(roundUp==true)
                {
                	lastDigit = Character.getNumericValue(x.charAt(x.length()-1));
                    lastDigit++;
                    x = x.substring(0, x.length() - 1);	//deletes last char in string
                    roundedLast = Integer.toString(lastDigit);
                    x = x + roundedLast;
                }
    		}
    	}
    		
    	return x;
    }
    
    //returns the number of significant figures in a number
    //returns -1 or -2 if there is an error
    protected int getSigFigs(String in)
    {
        String num = in;
        int i = 1;
        
        if(num != null && num.length() != 0)
        {
        	//if-else might not be needed if front end can ensure the right input
        	if(in.contains("."))
        	{
        		if(in.startsWith("0") || in.startsWith("."))
        		{
        			i = in.indexOf('.');
        			
        			while(in.charAt(++i) == '0') { }
        		}
        	}
        	else
        	{
        		return (-2); //not a decimal value
        	}
        }
        else
        {
        	return (-1); //not a number
        }
        
        return in.length() - i;
    }
    
    //returns the number of digits after the decimal point
    protected int getDecPlaces(String in)
    {
    	int decPlace = 0;
    	String num = in;
        
        if (num != null && num.length() != 0)
        {
        	//get the decPlace
            decPlace = (num.length() - num.indexOf(".")) - 1;
        }
    	
        return decPlace;
    }
    
    //not used
    //check and compare decimal places
    /*
    protected int getDecPlaces(int x, String in)
    {
        int decPlace = 0; 
        String num = in;
        
        if (num != null && num.length() != 0)
        {
            //get the decPlace
            decPlace = (num.length() - num.indexOf(".")) -1;
            
            if(decPlace == 0) 
            {
            	//System.out.println(decPlace);
            	//return decPlace; 
            }
            //Quadruple beam balance
            if ((x > 1 && x < 4) && decPlace != 3)
            {
            	//System.out.println(decPlace);
            	return (-1); 
            }
            //Analytical balance
            if ((x > 3 && x < 10) && decPlace != 4)
            {
            	//System.out.println(decPlace);
            	return (-1);
            }
            //Results
            if ((x > 9 && x < 12) && decPlace != 4)
            {
            	//System.out.println(decPlace);
            	return (-1);
            }
            /* hold this part for test
            //move past everything leading .
            int i = 0;
            while (num.charAt(i) != '.' && i < num.length())
            {
               i++;
            }
            
            //move past .
            if (num.charAt(i) == '.' && i < num.length())
            {
                i++;
            }
            
            //add dec places
            while (i < num.length())
            {
                decPlace ++;
            }
            
            return decPlace;   
        }
        else
        {
        	return (-1);
        }
    }
    */
    
    //formats decimal value into a given number of decimal places
    protected String setDecPlaces(String in, int places)
    {
        String format = "%." + places + "f";
        in = String.format(format, Double.parseDouble(in));
        return in;
    }
    
    //not used    
    //check and set the decimal format for 1 to 4 places
    /*
    protected String setDecimalFormat(String in, int places)
    {
    	String format = "#.";
    	
    	for(int i = 0; i < places; ++i)
    	{
    		format = format + "#";
    	}
    	
    	DecimalFormat df = new DecimalFormat(format);
    	df.setRoundingMode(RoundingMode.HALF_UP);
    	
    	Double temp = Double.parseDouble(in);
    	Double temp1 = temp.doubleValue(); 
    	String s = df.format(temp1);
    	StringBuilder s1 = new StringBuilder(s);
    	int decimalPlace = getDecPlaces(s);
    	
    	//for lab:1 result part only (apply with only 4 decimal values)
    	if (decimalPlace == 3)
    	{
    		s1.append("0");
    		s = s1.toString();
    	}
    	else if (decimalPlace == 2)
    	{
    		s1.append("00");
    		s = s1.toString();
    	}
    	else if (decimalPlace == 1 && in.charAt(in.length() - 1) != '0')
    	{
    		s1.append("000");
    		s = s1.toString();
    	}
    	else if (decimalPlace == 1 && in.charAt(in.length() - 1) == '0'  )
    	{
    		s1.append(".0000");
    		s = s1.toString();
    	}
    	return s;
    }
    */
    
    //called from front end; stores lab data into table
    //does not submit for grading
    public void save(int labNumber, String userid, String courseid)
    {
        //build string of data to save
        String inData = "";
        
        for (int i = 0; i < dataX; i++)
        {
            for (int j = 0; j < dataY; j++)
            {
                inData += data[i][j];
                
                if (i + j < dataX + dataY - 2)
                {
                    inData += ",";
                }
            }
        }
        
        //save to back end
        //save.saveData(tableName, labNumber, userid, courseid, inData);
    }
    
    public void check()
    {
        for (int i = 0; i < dataX; i ++)
        {
            for (int j = 0; j < dataY; j++)
            {
                if (data[i][j] != null && !data[i][j].equals(""))
                {
                    //clear previous errors
                    error[i][j] = "";
                    //clear previous corrections
                    isCorrect[i][j] = "";

                    //check based on type
                    if (type[i][j].equals("Unit"))
                    {
                        unitStandard(i,j);
                    }
                    if (type[i][j].equals("Double"))
                    {
                        doubleStandard(i,j);
                    }
                    if (type[i][j].equals("Integer"))
                    {
                        integerStandard(i,j);
                    }
                }
                else
                {
                    error[i][j] = "empty";
                }           
            }
        }
    }

    public void clear()
    {
        for (int i = 0; i < dataX; i ++)
        {
            for (int j = 0; j < dataY; j++)
            {
                if (data[i][j] != null && !data[i][j].equals(""))
                {
                    //clear data
                    data[i][j] = "";
                }

                if (error[i][j] != null && !error[i][j].equals(""))
                {
                    //clear previous errors
                    error[i][j] = "";
                }
                
                if (isCorrect[i][j] != null && !isCorrect[i][j].equals(""))
                {
                    //clear previous corrections
                	isCorrect[i][j] = "";
                }
                    
                if (key[i][j] != null && !key[i][j].equals(""))
                {
                    //remove any built key
                    key[i][j] = "";
                }
            }
        }
    }
    
    //called from front end; stores lab data and relevant metadata
    //submits for grading
    public void submit(int labNumber, String userid, String courseid, double gradeTotal)
    {
        //build strings for lab data and metadata
        String inData = "";
        String saveIsCorrect = "";
        String saveErrorMsgs = "";
        String saveScores = "";
        String saveKey = "";
        
        for (int i = 0; i < dataX; i++)
        {
            for (int j = 0; j < dataY; j++)
            {
                inData += data[i][j];
                saveIsCorrect += isCorrect[i][j];
                saveErrorMsgs += error[i][j];
                saveScores += grade[i][j];
                saveKey += key[i][j];
                
                if (i + j < dataX + dataY - 2)
                {
                    inData += ",";
                    saveIsCorrect += ",";
                    saveErrorMsgs += ",";
                    saveScores += ",";
                    saveKey += ",";
                }
            }
        }
        
        saveScores += "," + gradeTotal;
        /*
        boolean flag = save.submitData(tableName, labNumber, userid, courseid, 
        		inData, saveIsCorrect, saveErrorMsgs, saveScores, saveKey);
        
        if(flag)
        	LOGGER.debug("Data submitted.");
        */
        //save.saveGrade(theString);

        //set submitted
        //save.submitted(ctx, labname, jspname);
    }

    protected void buildKey()
    {
    	
    }
    /*
    public void clearAttempt(Context ctx, String uid, String labname)
    {
    	save.clearAttempt(ctx, uid, labname);
    }
    */
}