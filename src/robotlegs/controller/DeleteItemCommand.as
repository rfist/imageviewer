package robotlegs.controller
{
	import flash.geom.Point;

	import org.robotlegs.mvcs.Command;

	import robotlegs.model.GalleryModel;

	import robotlegs.model.ImageEvent;
	import robotlegs.view.GalleryItem;

	/**
	 * DeleteItemCommand.
	 *
	 */
	public class DeleteItemCommand extends Command
	{
		[Inject]
		public var event:ImageEvent;

		[Inject]
		public var galleryModel:GalleryModel;

		public function DeleteItemCommand()
		{

		}

		// Methods


		// Event handlers

		override public function execute():void
		{
//			event.data.source.alpha = 0.5;
			var item:GalleryItem = event.data as GalleryItem;
			var deletePoint:Point = new Point(item.source.x, item.source.y);
			galleryModel.loadedItems.splice(galleryModel.loadedItems.indexOf(item), 1);
			item.dispose();
			eventDispatcher.dispatchEvent(new ImageEvent(ImageEvent.CREATE_NEW_REQUESTED, deletePoint));
		}
	}
}