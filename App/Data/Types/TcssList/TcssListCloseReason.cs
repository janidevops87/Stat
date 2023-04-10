namespace Statline.Stattrac.Data.Types.TcssList
{
	public enum TcssListCloseReason
	{
		None = 0,
		ClosedPlacedHigherSequence = 1,
		ClosedNewMatchRun = 2,
		ClosedMatched = 3,
		ClosedRefusedforAllPatients = 4,
		ClosedDonorAborted = 5,
		ClosedDidNotDie = 6
	}
}
