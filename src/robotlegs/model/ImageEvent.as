package robotlegs.model
{
	import flash.events.Event;

	/**
	 * MessageModelEvent.
	 *
	 */
	public class ImageEvent extends Event
	{

		public static const CREATE_NEW_REQUESTED:String = 'create_new_requested';
		public static const IMAGE_READY:String = 'image_ready';
		public static const DELETE_ITEM_REQUESTED:String = 'delete_item_requested';

		private var _data:Object = {};
		public function ImageEvent(type:String, data:Object = null)
		{
			super(type);
			_data = data;
		}

		public function get data():Object
		{
			return _data;
		}
	}
}