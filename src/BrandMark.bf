using System;
using System.IO;
namespace BeefBrand
{
	class BrandMark : Compiler.Generator
	{
		public override String Name => "BrandMarkFile";

		public override void Generate(String outFileName, String outText, ref Flags generateFlags)
		{
			outFileName.Append(mParams["name"]); //Set the name of the file we created

			//Calculate the path of the file
			String path = scope .(); //The path of the data
			if(mParams["relative"] == bool.TrueString) //The path is relative to the
				path.Append(WorkspaceDir);
			path.Append(mParams["path"]);

			//Load data and check for file existence
			String data = scope .();
			if(File.Exists(path))
				data = File.ReadAllText(path,.. new String(),true);
			else
				Fail("The file at path doesnt exist");

			String param = scope String(mParams["name"]);
			String lenght = data.Length.ToString(.. scope .());
			String hex = ToHex(.. scope .(),data);
			outText.Append(
				scope $"""
				static
				\{
					extension Assets
					\{
						uint8[{lenght}] {param} = .({hex});
					\}
				\}
				"""
				);
		}
		///Create array of hex values from data String
		private void ToHex(String outText, String data)
		{
			for(int i = 0; i < data.Length; i++)
			{
				outText.Append("0x");
				outText.Append(
					((uint8)data[i]).ToString(.. scope .(),"X2",null)
					); //Doing magic here
				if(i+1 < data.Length)
					outText.Append(','); //Add an , if its not the last object
			}
		}

		public override void InitUI()
		{
			AddEdit("name","Object Name","Asset");
			AddEdit("path","File Path","C:\\Programs\\Beeflang");
			AddCheckbox("relative","Relative to workspace ?",false);
		}
	}
	
	
}
static
{
	class Assets
	{
		//This is where the generator will add files to
	}
}