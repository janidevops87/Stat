namespace Statline.StatTrac.Domain.Common;

// Historically, some fields which
// naturally are boolean, are represented
// by integer values, where True can be
// either 1 or -1, and False is 0.
// TODO: Find out what was the reason
// for this design, and which kind of
// True to use when.
public enum IntegerBoolean : short
{
    MinusOneTrue = -1,
    OneTrue = 1,
    ZeroFalse = 0,
}
