using System;
using System.IO;
using System.Collections;

namespace AssetBuilder
{
	class Program
	{


		public static void Main(String[] args)
		{
			
			Arguments.FormatArgs(args); //Format the arguments
			
			//There currently only is the way to do it with the pathvariables, you could also promt the winapi open folder dialogue and do that
			if(Arguments.GetString("path") case .Ok(StringView parsed)) //is a argument called path there ?
			{

				Dictionary<String,String> Data = scope Dictionary<String, String>(); //Stores data from the files
				String FileOutName = scope String(); //The name of the output file
				FileEnumerator AssetableFiles = Directory.EnumerateFiles(parsed); //List of files that are in the folder we wanna hardcode
				String FileData = new String(); //The String representation of the final output

				for(FileFindEntry i in AssetableFiles)
				{
					//Read and add data to the dictionary
					String output = new String();
					String filepath = new String();
					i.GetFilePath(filepath);
					if(File.ReadAllText(filepath,output,true) case .Ok) 
					{
						Data.Add(filepath,output);
					}
				}

				//Start adding data to the file
				FileData.Append("class ");
				StringSplitEnumerator enumerator = parsed.Split('/');
				for(StringView i in enumerator)
				{
					if(!enumerator.HasMore)
					{
						StringSplitEnumerator classes = i.Split('\\');
						for(StringView a in classes)
						{
							if(!classes.HasMore)
								FileData.Append(a);
						}
						FileData.Append(i);
						FileOutName.Append(i);
						FileOutName.Append(".bf");
						
					}
				}
				FileData.Append("\n { \n");
				for((String,String) i in Data )
				{
					String temp = scope String(scope $"public static uint8[{i.1.Length}] ");
					FileData.Append(temp);
					StringSplitEnumerator classes = i.0.Split('\\');
					for(StringView a in classes)
					{
						if(!classes.HasMore)
							FileData.Append(a);
					}
						
					FileData.Append(" = .(");
					for(int program = 0; program < i.1.Length;program++)
					{

						String hexval = scope String();

						((uint8)i.1[program]).ToString(hexval,"X2",null);

						FileData.Append($"0x",hexval); //Append each character
						FileData.Append(",");
					}
					FileData.Append("); \n");
				}
				FileData.Append("}");
				File.WriteAllText(FileOutName,FileData);
			}
			
		}

		
		

	}
}