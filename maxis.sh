package test;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class maxis {

	public static void main(String[] args){
		
		List<Integer> tam = new ArrayList<Integer>();
			tam.add(512);
			tam.add(1024);
			tam.add(3072);
			tam.add(6144);
			
		List<Integer> perio = new ArrayList<Integer>();
			perio.add(10);
			perio.add(100);
			perio.add(500);
			perio.add(1000);

		String ruta="/home/jorg/Desktop/weekend/mqtt/test";
		
		String filename;
		String resto;	
		String fullname="";
  	  	ArrayList<Integer> arrMax = new ArrayList<Integer>();
  	  	ArrayList<Integer> arrMin = new ArrayList<Integer>();
  	  	
		for (Integer tama : tam) {
			
			//create folder max
			String ruta2=ruta+"/"+tama+"/max";
			System.out.println(ruta2);

			boolean success;
			//if (tam.get(0) != 512) 
				success = (new File(ruta2)).mkdir();
			//else
			//	success = true;
				
			if (!success) {
			    // Directory creation failed
				System.out.println("Folder creation failed!");
			} else {

				for (Integer period : perio){
					//for (int count=1; count<=100; count++){
					
					//FIXME
					//Voy a utlizar los 5 primeros en lugar de los 100
					for (int count=1; count<=100; count++){
				
						System.out.println("--------------------------");
						resto="/"+tama+"/"+period+"/";
						
						//filename="s"+tama+"T"+period+".out"+count+".res";
						///FIXME
						//no tengo los punto res voy a utilizar los sus
						filename="s"+tama+"T"+period+".out"+count+".res";
						//String filename="s512T1000.out1.res";
						fullname=ruta+resto+filename;
	
						System.out.println("ruta:"+fullname);
				  	  	File f = new File(fullname);
				  	  	int maxi, mini;
				  	  	
				  	  	ArrayList<Integer> arr = new ArrayList<Integer>();
	
						 if(f.exists() && !f.isDirectory()) {  
				   		  
					   		  try {				//cargamos el fichero en el vector
					   			  arr=input(fullname);
					   		  } catch (Exception e) {
					   				e.printStackTrace();
					   		  }  
					   		
					   		  if (arr.size() != 0) {
					   			  System.out.println("making a VECTOR");
					   			  
					   			  maxi = Collections.max(arr);
					   			  mini = Collections.min(arr);
						    		  
					   			  arrMax.add(maxi);
					   			  arrMin.add(mini);
					   		  }
				   		  
						 } else {
							 System.out.println("Don't exits");
						 }
				
					}

					//obtener los maximos
//			    	for(int i1 = 0; i1 < arrMax.size(); i1++) {
//					  System.out.println(arrMax.get(i1));
//			    	}
			    	String maxName=ruta2+"/s"+tama+"T"+period+".max";
			    	saveVectorInFile(arrMax, maxName);
			    	arrMax.clear();
		   			arrMin.clear();

			    	
				} //for period
						
			  }	//else if_exist_max_folder
			
			}	//for tama

		}		//end main
   		  
   		/*******************************************************
   		 * 						INPUT
   		 * 
   		 * *****************************************************
   		 */
   		
   		public static ArrayList<Integer>input(String path){

   			BufferedReader br = null;
   			ArrayList<Integer> todo = new ArrayList<Integer>();

   			try {
   				 String sCurrentLine;
   				 br = new BufferedReader(new FileReader(path));
   				 
   				 try {
   					while((sCurrentLine = br.readLine()) != null){
   						 	
   						try{
   						    int val;
   						    val=Integer.valueOf(sCurrentLine);
   						    //System.out.println(val);
   						    todo.add(val);
   					    } catch (NumberFormatException e) {
   					        //not an integer
   					    	System.out.println("not an integer");
   					    }
   					 }
   				 }catch (IOException e) {
   					e.printStackTrace();
   				 }finally {
   					 try {
   						 if (br != null)
   			            	br.close();
   					 } catch (IOException ex) {
   						 ex.printStackTrace();
   					 }
   				 }
   			} catch (IOException e) {
   				e.printStackTrace();
   			}
   			return(todo);
   		}
	
   		/*******************************************************
   		 * 						PRINT  &  SAVE  THE   RESULTS
   		 * 
   		 * *****************************************************
   		 */

   		public static void saveVectorInFile(ArrayList<Integer> vector, String fileName){
   			
   	        //writing to file 		
   	        String fileOut=fileName;
   	  		BufferedWriter bw3 = null;
   			
   	  		File f = new File(fileOut);
   	    	  
   	  		if(f.exists() && !f.isDirectory()) { /* do something */ 
   	    		  try {
   	    			  //eliminar el fichero que existia previamente
   	    			  f.delete(); 
   	    		  } catch (Exception e) {
   	    				e.printStackTrace();
   	    		  }
   	  		}
   	    	  
   	  		try {
   				bw3 = new BufferedWriter(new FileWriter(fileOut, true));
   			} catch (IOException e) {
   				e.printStackTrace();
   			}
   			for (int a = 0; a < vector.size(); a++) {
   	   			try {
   	   				//bw3.write(a + " " + maximos.get(a) + "\n");
   	   				//sin el identificador
   	   				bw3.write(vector.get(a) + "\n");
   	 			} catch (IOException e) {
   					e.printStackTrace();
   				}
   	  		}
   			try {
   				bw3.close();
   			} catch (IOException e) {
   				e.printStackTrace();
   			}  

   		}
}
