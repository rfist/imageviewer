package robotlegs.model
{
	import flash.events.Event;

	/**
	 * MessageModelEvent.
	 *
	 */
	public class MessageModelEvent extends Event
	{

		public static const LOG_MESSAGE_ADDED:String = "log_message_added";
		public static const GALLERY_MODEL_UPDATED:String = "gallery_model_updated";

		private var _data:Object = {};
		public function MessageModelEvent(type:String, data:Object = null)
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