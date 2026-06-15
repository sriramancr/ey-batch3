import os, mysql.connector, psycopg as psy, pandas as pd, json, random
from dotenv import load_dotenv
from openai import OpenAI

env_file = "D:/stackroute/2_AI-assisted-programming/learning_requirements/cognizant/2025/1/code/2_AgenticAI/db_connections.env"

load_dotenv(env_file)

# MySQL connections
MS_HOST=os.getenv("MS_HOST")
MS_PORT=os.getenv("MS_PORT")
MS_USER=os.getenv("MS_USER")
MS_PASSWORD=os.getenv("MS_PASSWORD")
MS_DATABASE = "finance"

# ------------- Functions ------------------------
# Connect to an existing MySQL database
def get_mysql_conn():
    try:
        conn = mysql.connector.connect( host=MS_HOST, port=MS_PORT, database=MS_DATABASE, user=MS_USER, password=MS_PASSWORD)
    except Exception as e:
        conn = str(e)

    return(conn)


# Run a query in the database
# def FetchData(CONN, query):
def ExecuteQuery(CONN,query,action):
    try:
        cursor = CONN.cursor()
        status = []

        cursor.execute(query)

        if action == "S": # select query
            data = cursor.fetchall()
            cols = [c[0] for c in cursor.description]
            data = pd.DataFrame(data, columns=cols)
            status.extend(["SUCCESS", data])
        elif action in ["I","U","D"]:
            CONN.commit()
            status.extend(["SUCCESS", pd.DataFrame({"status": ["Record added / changed"]})])

    except Exception as e:
        status.extend(["EXCEPTION", str(e)])

    cursor.close()
    return (status)

# LLM response call
def GetResponse(system_prompt, user_prompt):
    try:
        response = []

        client = OpenAI()

        msg = [
            {'role': 'system', 'content': system_prompt},
            {'role': 'user', 'content': user_prompt}
        ]

        resp = client.chat.completions.create(model='gpt-4o', messages=msg)
        answer = resp.choices[0].message.content
        response.extend(["SUCCESS", answer])  # success

    except Exception as e:
        response.extend(["EXCEPTION", "EXCEPTION from getresponse(). " + str(e)])

    return (response)

# ------------------ End of Functions ---------------------------

# connect to the MySQL instance with the credentials and instantiate a Cursor object for queries
CONN = get_mysql_conn()
print(CONN)

# COMPONENT 1: GOAL
# --------------------------------------------------
GOAL = """ Detect risky financial data access events and classify them as:
Normal, Monitor, Investigate, or Critical.
Also explain the reason and assign the right editor/owner.
"""

# COMPONENT 2: PERCEPTION
# --------------------------------------------------

def perceive_event(event_id):
    try:
        ret = []

        query = f'''select * from data_security where event_id = '{event_id}' '''
        # fetch = FetchData(CONN, query)
        fetch = ExecuteQuery(CONN,query,"S")
        status = fetch[0]
        data = fetch[1]
        ret.extend([status,data])

    except Exception as e:
        ret.extend(["EXCEPTION",[]])

    return (ret)

ret_event = perceive_event("E0006")
status = ret_event[0]
if status == "SUCCESS":
    security_event_data = ret_event[1]
    # print(security_event_data)

event_data = security_event_data[['event_id','department','risk_score']]

# json.dumps(data,indent=2,default=str)

# COMPONENT 3: REASONING USING LLM
# --------------------------------------------------

def reason_with_llm(event_data):
    try:
        client = OpenAI()

        user_prompt = f""" You are a financial data security AI agent.
    
        Goal:
        {GOAL}
        
        Analyze the following access event:
        {json.dumps(event_data, indent=2, default=str)}
        
        Return output strictly as JSON with:
        - risk_category
        - reasoning
        - key_risk_signals
        - confidence_score
        DO NOT include any other extra text / characters / ```json etc.
        
        Risk categories:
        Normal, Monitor, Investigate, Critical
        """

        sys_prompt = "You are a security risk reasoning assistant."

        response = GetResponse(system_prompt=sys_prompt, user_prompt=user_prompt)

    except Exception as e:
        response = ["EXCEPTION", str(e)]

    return (response)

ret_reason = reason_with_llm(event_data)
print(ret_reason)

reasoning_result = ret_reason[1]
# Convert the string output into a JSON format for downstream processing
reasoning_result = json.loads(reasoning_result)


# COMPONENT 4: PLAN
# --------------------------------------------------

def create_plan(reasoning_result):
    try:
        ret = []

        category = reasoning_result["risk_category"]

        if category == "Critical":
            plan = [
                "Immediately escalate to SOC Manager",
                "Check unauthorized access indicators",
                "Trigger incident response workflow",
                "Notify compliance team"
            ]
        elif category == "Investigate":
            plan = [
                "Assign to Security Analyst",
                "Review user activity history",
                "Validate access pattern",
                "Check DLP and authentication logs"
            ]
        elif category == "Monitor":
            plan = [
                "Keep event under observation",
                "Check if similar events repeat",
                "Review anomaly and risk score trends"
            ]
        else:
            plan = [
                "Mark as normal",
                "No immediate action required"
            ]
        ret.extend(["SUCCESS", plan])

    except Exception as e:
        ret.extend(["EXCEPTION", "create_plan(). " + str(e)])

    return (ret)

ret_plan = create_plan(reasoning_result)
plan_status = ret_plan[0]
plan = ret_plan[1]
print(plan)

# COMPONENT 5: ACT
# --------------------------------------------------

def assign_owner(reasoning_result):
    category = reasoning_result["risk_category"]

    if category == "Critical":
        return "SOC Manager"
    elif category == "Investigate":
        return "Security Analyst"
    elif category == "Monitor":
        return "Risk Monitoring Team"
    else:
        return "No Owner Required"

def act_on_event(event, reasoning_result, plan):
    owner = assign_owner(reasoning_result)

    action_result = {
        "event_id": security_event_data["event_id"][0],
        "original_label": security_event_data["breach_scenario_label"][0],
        "agent_decision": reasoning_result["risk_category"],
        "assigned_owner": owner,
        "reasoning": reasoning_result["reasoning"],
        "key_risk_signals": reasoning_result["key_risk_signals"],
        "confidence_score": reasoning_result["confidence_score"],
        "plan": plan
    }

    return action_result

action_result = act_on_event(event_data, reasoning_result, plan )
print(action_result)

# COMPONENT 6: FEEDBACK
# --------------------------------------------------

def collect_feedback():
    print("\nFeedback Options:")
    print("1. Accepted")
    print("2. Corrected")
    print("3. Escalated")

    choice = random.randint(1,3)
    print(f"Randomly selected choice: {choice}")

    if choice == 1:
        feedback = "Accepted"
    elif choice == 2:
        feedback = "Corrected"
    elif choice == 3:
        feedback = "Escalated"
    else:
        feedback = "No Feedback"
    return(feedback)

feedback = collect_feedback()
print(feedback)

# COMPONENT 7: MEMORY
# --------------------------------------------------

def store_memory(action_result, feedback):
    try:
        ret = []

        query = f""" INSERT INTO agent_memory ( event_id, original_label, agent_decision, assigned_owner, 
                    reasoning, analyst_feedback)  VALUES
                    ( '{action_result["event_id"]}', '{action_result["original_label"]}', 
                      '{action_result["agent_decision"]}', '{action_result["assigned_owner"]}', 
                      '{action_result["reasoning"]}', '{feedback}' ); """

        ret_memory = ExecuteQuery(CONN, query, "I")
        status = ret_memory[0]

        if status == "SUCCESS":
            ret.extend([status, "1 Record added successfully into Agent Memory"])

    except Exception as e:
        ret.extend([status, str(e)])

    return(ret)


ret_memory = store_memory(action_result,feedback)
print(ret_memory)

def view_agent_memory():
    try:
        ret = []
        query = f'''select * from agent_memory; '''
        fetch = ExecuteQuery(CONN, query, "S")
        status = fetch[0]
        data = fetch[1]
        ret.extend([status, data])

    except Exception as e:
        ret.extend([status, str(e)])

    return (ret)

ret_agent_memory = view_agent_memory()
print(ret_agent_memory[1])