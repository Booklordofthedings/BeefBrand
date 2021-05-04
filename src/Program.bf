using System;
using System.IO;
using System.Collections;

namespace AssetBuilder
{
	class Program
	{
		/*
		                                                                       
		 _____         _   _           _     ___ _   _         _ _             
		| __  |___ ___| |_| |___ ___ _| |___|  _| |_| |_ ___ _| |_|___ ___ ___  
		| __ -| . | . | '_| | . |  _| . | . |  _|  _|   | -_| . | |   | . |_ -|
		|_____|___|___|_,_|_|___|_| |___|___|_| |_| |_|_|___|___|_|_|_|_  |___|
		                                                              |___|    
		| Booklordofthedings | Jannis von Hagen | Booklordofthe.dev |      



		-BeefBrand-
		A simple Asset Hardcoder
		v.1.3

		Guide:
			Call the .exe with the --path argument pointing to the folder you want to compile
		*/

		public static void Main(String[] args)
		{
			
			Arguments.FormatArgs(args); //Format the arguments
			char8** pathinput = scope char8*();
			//There currently only is the way to do it with the pathvariables, you could also promt the winapi open folder dialogue and do that
			if(Arguments.GetString("path") case .Ok(StringView parsed)) //is a argument called path there ?
			{
				Run(parsed);
				
			}
			else if(NativeFileDialog.NativeFileDialog.PickFolder("C:", pathinput) case .Okay)
			{
				Run(StringView(*pathinput));
			}
			
		}


		public static void Run(StringView parsed)
		{
			Dictionary<String,String> Data = scope Dictionary<String, String>(); //Stores data from the files
			String FileOutName = scope String(parsed); //The name of the output file
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
			if(Arguments.GetValue("out") case .Ok(FileOutName)){} //Test for the out argument
			StringSplitEnumerator enumerator = parsed.Split('\\');
			for(StringView i in enumerator)
			{
				if(!enumerator.HasMore)
				{
					FileOutName.Append("\\");
					FileOutName.Append(i);
					FileOutName.Append(".bf"); //output file name
					FileData.Append(i); //class name
				}
			}

			FileData.Append("\n{\n");
			//Actual data starts here
			for((String,String) i in Data )
			{
				StringSplitEnumerator noEndings = i.0.Split('.'); //'.' whats dis ?
				String FileName = scope .();
				for(StringView c in noEndings)
				{
					FileName = scope String(c);
					break;
				}

				//This way we can make the file static and save alot alot of compile time
				String temp = scope String(scope $"public static uint8[{i.1.Length}] ");
				FileData.Append(temp);

				//So that we can get the actual filename. There probably is a way to do this faster, but you would need someone less stupid than me to do that.
				StringSplitEnumerator classes = FileName.Split('\\');
				for(StringView a in classes)
				{
					if(!classes.HasMore)
						FileData.Append(a);
				}

				//The actual data from the file
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