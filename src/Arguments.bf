using System;
using System.Collections;

	/*
	-Easy Arguments-
	A simple argument organizer made by: Booklordofthedings(Jannis von Hagen)
	v.1.0
	
	Guide:
		Call FormatArgs with the arguments from main
		Command now has the corresponding command, if none are specified its "run"
		GetValueType will return the corresponding type to the key that you supplied
	*/

	class Arguments
	{

		//Members shouldnt be directly acesssed, and instead should be
		private	static StringView mCommand = "run";
		private static Dictionary<StringView,StringView> mArguments = new .() ~ delete _; //Shorthand initialization and destructor
		private static bool mIsInit = false;


		public static void FormatArgs(String[] args)
		{

			//Return if the arguments are closed
			if(args.IsEmpty)
			{
				return;
			}

			//Loop through the arguments
			for(int i = 0;i < args.Count; i++)
			{
				args[i].ToLower(); //To lowercase each argument
				if(!args[i].StartsWith("--") && mCommand == "run" && i == 1) //checks if a command is specified
				{
					mCommand = args[i]; //Then sets the command
				}
				else
				{
					if(	(i+1 < args.Count)) //is there another command in the line after this one
					{
						if(!args[i+1].StartsWith("--")) //Does the next command start with a good specifier
						{
							
							mArguments.Add(args[i].Substring(2),args[i+1]); //Add the key/value pair to the dictionary
							i++; //skip over one
						}
					}
				}
			}
			mIsInit = true;
			return;
		}


		public static StringView GetCommand()
		{
			return mCommand;
		}

	   
		///Get any Value from a String
		public static Result<StringView> GetValue(String Key)
		{
			Result<StringView> sucess = .Err;
			if(mIsInit && mArguments.ContainsKey(Key))
			{
				sucess = .Ok(mArguments[Key]);
			}
			return sucess;
		}

		///Get a value from a key as a String
		public static Result<StringView> GetString(String Key)
		{
			Result<StringView> sucess = .Err;
			if(mIsInit && mArguments.ContainsKey(Key))
			{
				sucess = .Ok(mArguments[Key]);
			}
			return sucess;
		}

		///Get a value from a key as a Float
		public static Result<float> GetFloat(String Key)
		{
			Result<float> sucess = .Err;
			StringView output;
			if(mIsInit && mArguments.ContainsKey(Key))
			{
				output = mArguments[Key];
				if(float.Parse(output) case .Ok(float returnval))
					sucess = .Ok(returnval);
			}
			return sucess;
		}
		
		///Get a value from a key as a Int
		public static Result<int> GetInt(String Key)
		{
			Result<int> sucess = .Err;
			StringView output;
			if(mIsInit && mArguments.ContainsKey(Key))
			{
				output = mArguments[Key];
				if(int.Parse(output) case .Ok(int returnval))
					sucess = .Ok(returnval);
			}
			return sucess;
		}


		
		///Get a value from a key as a Bool
		public static Result<bool> GetBool(String Key)
		{
			Result<bool> sucess = .Err;
			StringView output;
			if(mIsInit && mArguments.ContainsKey(Key))
			{
				output = mArguments[Key];
				if(bool.Parse(output) case .Ok(bool returnval))
					sucess = .Ok(returnval);
			}
			return sucess;
		}
		
	}

