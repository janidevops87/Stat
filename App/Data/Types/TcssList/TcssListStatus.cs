namespace Statline.Stattrac.Data.Types.TcssList
{
	public enum TcssListStatus
	{
		None = 0,
		ReceiptPending = 1,
		AcknowledgetoEvaluate = 2,
		LabsTestsPending = 3,
		LabsReceived = 4,
		ContactTransplantCoordinator = 5,
		ContactSurgeon = 6,
		ListMonitoring = 7,
		QA= 8,
		Closed = 9
	}
}
