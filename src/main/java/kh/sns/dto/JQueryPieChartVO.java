package kh.sns.dto;

/**
 * @author user1
 *
 */
public class JQueryPieChartVO {
	
	private String label;
	private double y;
	private String legendText;
	
	public JQueryPieChartVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public JQueryPieChartVO(String label, double y, String legendText) {
		super();
		this.label = label;
		this.y = y;
		this.legendText = legendText;
	}
	/**
	 * @return the label
	 */
	public String getLabel() {
		return label;
	}
	/**
	 * @param label the label to set
	 */
	public void setLabel(String label) {
		this.label = label;
	}
	/**
	 * @return the y
	 */
	public double getY() {
		return y;
	}
	/**
	 * @param y the y to set
	 */
	public void setY(double y) {
		this.y = y;
	}
	/**
	 * @return the legendText
	 */
	public String getLegendText() {
		return legendText;
	}
	/**
	 * @param legendText the legendText to set
	 */
	public void setLegendText(String legendText) {
		this.legendText = legendText;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "JQueryPieChartVO [label=" + label + ", y=" + y + ", legendText=" + legendText + "]";
	}

}
