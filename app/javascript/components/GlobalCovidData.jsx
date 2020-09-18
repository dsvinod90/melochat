import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import {Spring, config} from 'react-spring/renderprops'

class GlobalCovidData extends React.Component {
  constructor(props) {
    super(props);
    this.renderSuccessResponse = this.renderSuccessResponse.bind(this);
    this.renderFailureResponse = this.renderFailureResponse.bind(this);
    this.state = {
        totalConfirmedCases: null,
        totalRecoveredCases: null,
        totalDeathCases: null,
        newConfirmedCases: null,
        newDeathCases: null,
        newRecoveredCases: null,
        isVisible: false,
        hasErrored: false
    }
  }

  renderGlobalSummary() {
    fetch(this.props.globalSummaryUrl, {
      method: 'GET',
      headers: {'Content-Type': 'application/json',Accept: 'application/json' }
    })
    .then(
      response => {
        if (response.status >= 200 && response.status <= 299) {
          return response.json();
        } else {
          throw Error(response.statusText);
        }
      }
    )
    .then(data => { this.onSuccessApi(data); })
    .catch(error => { this.onFailureApi(error); })
  }

  onSuccessApi(obj) {
    this.setState(
        {
            totalConfirmedCases: obj['TotalConfirmed'],
            totalDeathCases: obj['TotalDeaths'],
            totalRecoveredCases: obj['TotalRecovered'],
            newConfirmedCases: obj['NewConfirmed'],
            newDeathCases: obj['NewDeaths'],
            newRecoveredCases: obj['NewRecovered'],
            isVisible: true,
            hasErrored: false
        }
    )
  }

  renderFailureResponse() {
      return(
        <div>
            <p>Global covid data temporarily not available. Please refresh in sometime.</p>
        </div>
      )
  }

  renderSuccessResponse(dataVisible) {
    if (dataVisible){
        return(
            <div>
                <table className='table table-sm font-weight-bold'>
                    <tbody>
                      <tr className='text-primary'>
                          <td className="text-center"> Total Confirmed </td>
                          <td className="text-center">
                              <Spring
                                from={{ number: this.state.totalConfirmedCases - 1000 }}
                                to={{ number: this.state.totalConfirmedCases }}
                                config={{ tension: 280, friction: 120, duration: 200, delay: 500 }}>
                                {props => <div>{props.number}</div>}
                              </Spring>
                            </td>
                      </tr>
                      <tr className='text-danger'>
                          <td className="text-center"> Total Deaths </td>
                          <td className="text-center">
                              <Spring
                                from={{ number: this.state.totalDeathCases - 1000 }}
                                to={{ number: this.state.totalDeathCases }}
                                config={{ tension: 280, friction: 120, duration: 200, delay: 500 }}>
                                {props => <div>{props.number}</div>}
                              </Spring>
                            </td>
                      </tr>
                      <tr className='text-success'>
                          <td className="text-center"> Total Recovered </td>
                          <td className="text-center">
                              <Spring
                                from={{ number: this.state.totalRecoveredCases - 1000 }}
                                to={{ number: this.state.totalRecoveredCases }}
                                config={{ tension: 280, friction: 120, duration: 200, delay: 500 }}>
                                {props => <div>{props.number}</div>}
                              </Spring>
                          </td>
                      </tr>
                      <tr className='text-primary'>
                          <td className="text-center"> New Confirmed </td>
                          <td className="text-center">
                              <Spring
                                from={{ number: this.state.newConfirmedCases - 1000 }}
                                to={{ number: this.state.newConfirmedCases }}
                                config={{ tension: 280, friction: 120, duration: 200, delay: 500 }}>
                                {props => <div>{props.number}</div>}
                              </Spring>
                          </td>
                      </tr>
                      <tr className='text-danger'>
                          <td className="text-center"> New Deaths </td>
                          <td className="text-center">
                              <Spring
                                from={{ number: this.state.newDeathCases - 1000 }}
                                to={{ number: this.state.newDeathCases }}
                                config={{ tension: 280, friction: 120, duration: 200, delay: 500 }}>
                                {props => <div>{props.number}</div>}
                              </Spring>
                          </td>
                      </tr>
                      <tr className='text-success'>
                          <td className="text-center"> New Recovered </td>
                          <td className="text-center">
                              <Spring
                                from={{ number: this.state.newRecoveredCases - 1000 }}
                                to={{ number: this.state.newRecoveredCases }}
                                config={{ tension: 280, friction: 120, duration: 200, delay: 500 }}>
                                {props => <div>{props.number}</div>}
                              </Spring>
                          </td>
                      </tr>
                    </tbody>
                </table>
            </div>
        )
    } else {
        return(
            <div>
                <p>Select a country to see the covid updates of that country.</p>
            </div>
        )
    }
  }

  onFailureApi(error) {
      console.log(error);
      this.setState(
          {
              hasErrored: true
          }
      )
  }

  componentDidMount() {
    this.renderGlobalSummary(this.props.globalSummaryUrl);
  }

  render() {
    let visible = this.state.isVisible;
    let errored = this.state.hasErrored;
    let covidData;
    if (!errored){
        covidData = this.renderSuccessResponse(visible);
    } else {
        covidData = this.renderFailureResponse();
    }
    return(
      <div>
        {covidData}
      </div>
    )
  }
}
export default GlobalCovidData;
