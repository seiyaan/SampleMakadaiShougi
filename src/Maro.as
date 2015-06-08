package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class Maro extends Sprite {
		
		[Embed(source="pic/masako_1.png")] private const PicMasako1:Class;
		[Embed(source="pic/masako_2.png")] private const PicMasako2:Class;
		[Embed(source="pic/maro_1.png")] private const PicMinamoto1:Class;
		[Embed(source="pic/maro_2.png")] private const PicMinamoto2:Class;
		
		private var ImageMasako1:Bitmap = new PicMasako1() as Bitmap;
		private var ImageMasako2:Bitmap = new PicMasako2() as Bitmap;
		private var ImageMinamoto1:Bitmap = new PicMinamoto1() as Bitmap;
		private var ImageMinamoto2:Bitmap = new PicMinamoto2() as Bitmap;
		
		private var ImageX:int = Main.WIDTH - ImageMinamoto1.width;
		private var ImageY:int = Main.HEIGHT - ImageMinamoto1.height;
		
		private var ImageComEnable:Bitmap;
		private var ImagePlayerEnable:Bitmap;
		private var ImageComDisable:Bitmap;
		private var ImagePlayerDisable:Bitmap;
		
		public function Maro() {
			ImagePlayerEnable = ImageMinamoto2;
			ImageComEnable = ImageMasako2;
			ImagePlayerDisable = ImageMinamoto1;
			ImageComDisable = ImageMasako1;
			
			ImagePlayerEnable.x = ImageX;
			ImagePlayerEnable.y = ImageY;
			ImagePlayerDisable.x = ImageX;
			ImagePlayerDisable.y = ImageY;
			
			addChild(ImageComEnable);
			addChild(ImagePlayerEnable);
			addChild(ImageComDisable);
			addChild(ImagePlayerDisable);
		}
		
		public function SetMaro():void {
			/*
			if(Player.getPlayer() == Player.PLAYER){
				ImageComEnable = ImageMasako1;
				ImagePlayerEnable = ImageMinamoto2;
			}
			else {
				ImageComEnable = ImageMasako2;
				ImagePlayerEnable = ImageMinamoto1;
			}
			
			addChild(ImageComEnable);
			addChild(ImagePlayerEnable);
			ImagePlayerEnable.x = ImageX;
			ImagePlayerEnable.y = ImageY;
			//this.visible = false;
			*/
		}
		
		public function ChangeMaro():void {
			//removeChild(ImageComEnable);
			//removeChild(ImagePlayerEnable);
			
			if(Player.getPlayer() == Player.PLAYER) {
				ImageComEnable.visible = false;
				ImagePlayerDisable.visible = false;
				ImageComDisable.visible = true;
				ImagePlayerEnable.visible = true;
				//ImageComEnable = ImageMasako1;
				//ImagePlayerEnable = ImageMinamoto2;
			}
			else {
				ImageComEnable.visible = true;
				ImagePlayerDisable.visible = true;
				ImageComDisable.visible = false;
				ImagePlayerEnable.visible = false;
				//ImageComEnable = ImageMasako2;
				//ImagePlayerEnable = ImageMinamoto1;
			}
			
			//addChild(ImageComEnable);
			//addChild(ImagePlayerEnable);
			//ImagePlayerEnable.x = ImageX;
			//ImagePlayerEnable.y = ImageY;
		}
	}
}