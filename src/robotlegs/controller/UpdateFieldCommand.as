package robotlegs.controller
{
	import com.greensock.TweenLite;

	import flash.display.DisplayObject;

	import org.robotlegs.mvcs.Command;

	import robotlegs.model.GalleryModel;
	import robotlegs.view.GalleryItem;

	/**
	 * UpdateFieldCommand.
	 *
	 */
	public class UpdateFieldCommand extends Command
	{
		[Inject]
		public var galleryModel:GalleryModel;

		public function UpdateFieldCommand()
		{

		}

		override public function execute():void
		{
			var parentObject:DisplayObject = galleryModel.loadedItems[0].source.parent;

			const Y_OFFSET:int = (parentObject.height - Config.IMAGE_HEIGHT * galleryModel.sortedImages.length) / ((galleryModel.sortedImages.length - 1) * 2 );
			for (var y:int = 0; y < galleryModel.sortedImages.length; y++)
			{
				var xPos: int = 5;
				var totalWidth:Number = 0;
				for (var x:int = 0; x < galleryModel.sortedImages[y].length; x++)
				{
					totalWidth += galleryModel.sortedImages[y][x].source.width;
				}

				const X_OFFSET:int = (parentObject.width - totalWidth) / galleryModel.sortedImages[y].length - 1;

				for (x = 0; x < galleryModel.sortedImages[y].length; x++)
				{
					var object:GalleryItem = galleryModel.sortedImages[y][x];
					var params:Object = {};
					params.x = xPos;
					params.y =  5 + y * (Config.IMAGE_HEIGHT + Y_OFFSET);
					TweenLite.to(object.source, 2, params);
					xPos += (object.source.width + X_OFFSET);
				}
			}
		}
	}
}